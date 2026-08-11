// Path: templates/tools-panel/server.mjs
// Summary: Serves a loopback-only Mangonur finishing panel and safely invokes local audio cleanup and caption workers inside one project root.
import http from 'node:http';
import {readFile, readdir, stat} from 'node:fs/promises';
import {spawn} from 'node:child_process';
import path from 'node:path';
import process from 'node:process';
import {fileURLToPath} from 'node:url';

const projectRoot = path.resolve(process.env.MANGONUR_PROJECT_ROOT || '');
const skillHome = path.resolve(process.env.MANGONUR_SKILL_HOME || '');
const port = Number(process.env.MANGONUR_TOOLS_PORT || 4317);
const here = path.dirname(fileURLToPath(import.meta.url));
const htmlPath = path.join(here, 'index.html');
const audioExtensions = new Set(['.wav', '.mp3', '.m4a', '.aac', '.flac', '.ogg']);

if (!process.env.MANGONUR_PROJECT_ROOT || !process.env.MANGONUR_SKILL_HOME) {
  throw new Error('MANGONUR_PROJECT_ROOT and MANGONUR_SKILL_HOME are required.');
}

const insideProject = (relativePath) => {
  const resolved = path.resolve(projectRoot, relativePath);
  if (resolved !== projectRoot && !resolved.startsWith(`${projectRoot}${path.sep}`)) {
    throw new Error('Path escapes the Mangonur project root.');
  }
  return resolved;
};

const walkAudio = async (directory, prefix = '') => {
  const output = [];
  for (const entry of await readdir(directory, {withFileTypes: true})) {
    if (entry.name === 'node_modules' || entry.name.startsWith('.')) continue;
    const absolute = path.join(directory, entry.name);
    const relative = path.join(prefix, entry.name);
    if (entry.isDirectory()) output.push(...await walkAudio(absolute, relative));
    if (entry.isFile() && audioExtensions.has(path.extname(entry.name).toLowerCase())) output.push(relative.split(path.sep).join('/'));
  }
  return output;
};

const readBody = async (request) => {
  const chunks = [];
  for await (const chunk of request) chunks.push(chunk);
  return JSON.parse(Buffer.concat(chunks).toString('utf8') || '{}');
};

const runPython = (script, args) => new Promise((resolve, reject) => {
  const executable = process.platform === 'win32' ? 'python' : 'python3';
  const child = spawn(executable, [script, ...args], {cwd: projectRoot, windowsHide: true});
  let stdout = '';
  let stderr = '';
  child.stdout.on('data', (chunk) => { stdout += chunk; });
  child.stderr.on('data', (chunk) => { stderr += chunk; });
  child.on('error', reject);
  child.on('close', (code) => code === 0 ? resolve(stdout.trim()) : reject(new Error(stderr.trim() || `Worker exited with code ${code}`)));
});

const sendJson = (response, statusCode, payload) => {
  response.writeHead(statusCode, {'content-type': 'application/json; charset=utf-8'});
  response.end(JSON.stringify(payload));
};

const server = http.createServer(async (request, response) => {
  try {
    if (request.method === 'GET' && request.url === '/') {
      response.writeHead(200, {'content-type': 'text/html; charset=utf-8'});
      response.end(await readFile(htmlPath, 'utf8'));
      return;
    }
    if (request.method === 'GET' && request.url === '/api/files') {
      sendJson(response, 200, {audio: await walkAudio(projectRoot)});
      return;
    }
    if (request.method === 'POST' && request.url === '/api/audio/process') {
      const body = await readBody(request);
      const source = insideProject(String(body.source || ''));
      if (!(await stat(source)).isFile()) throw new Error('Selected source is not a file.');
      const preset = String(body.preset || 'voice-clean');
      const gainDb = Number(body.gainDb || 0);
      const stamp = new Date().toISOString().replace(/[:.]/g, '-');
      const stem = path.parse(source).name.replace(/[^a-zA-Z0-9_-]+/g, '-');
      const destination = insideProject(path.join('processed', 'audio', `${stem}-${preset}-${stamp}.wav`));
      const script = path.join(skillHome, 'current', 'scripts', 'audio-tools.py');
      const output = await runPython(script, [source, destination, '--preset', preset, '--gain-db', String(gainDb)]);
      sendJson(response, 200, {ok: true, destination: path.relative(projectRoot, destination).split(path.sep).join('/'), worker: output});
      return;
    }
    if (request.method === 'POST' && request.url === '/api/captions/transcribe') {
      const body = await readBody(request);
      const source = insideProject(String(body.source || ''));
      if (!(await stat(source)).isFile()) throw new Error('Selected source is not a file.');
      const destination = insideProject(path.join('alignment', 'auto-captions.json'));
      const script = path.join(skillHome, 'current', 'scripts', 'transcribe-captions.py');
      const args = [source, destination, '--model', String(body.model || 'small'), '--language', String(body.language || 'tr')];
      const output = await runPython(script, args);
      sendJson(response, 200, {ok: true, destination: path.relative(projectRoot, destination).split(path.sep).join('/'), worker: output});
      return;
    }
    sendJson(response, 404, {error: 'Not found'});
  } catch (error) {
    sendJson(response, 400, {error: error instanceof Error ? error.message : String(error)});
  }
});

server.listen(port, '127.0.0.1', () => {
  console.log(`Mangonur Tools: http://127.0.0.1:${port}`);
});
