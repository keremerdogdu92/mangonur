from __future__ import annotations
import json, os, shutil, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REQ = json.loads((ROOT / 'runtime-requirements.json').read_text(encoding='utf-8-sig'))

def cmd_version(command: list[str]) -> str | None:
    try:
        result = subprocess.run(command, capture_output=True, text=True, timeout=15)
        text = (result.stdout or result.stderr).strip().splitlines()
        return text[0] if result.returncode == 0 and text else None
    except Exception:
        return None

def main() -> int:
    shared = os.environ.get('MANGONUR_WORKSPACE', '')
    local = os.environ.get('MANGONUR_LOCAL_WORKSPACE', '')
    skill = os.environ.get('MANGONUR_SKILL_HOME', '')
    report = {'runtimeVersion': REQ['runtimeVersion'], 'ok': True, 'checks': {}}
    for key, value in [('workspace', shared), ('localWorkspace', local), ('skillHome', skill)]:
        exists = bool(value) and Path(value).exists()
        report['checks'][key] = {'ok': exists, 'path': value}
        report['ok'] = report['ok'] and exists
    node = cmd_version(['node', '--version'])
    python = cmd_version([sys.executable, '--version'])
    ffmpeg = shutil.which('ffmpeg')
    if not ffmpeg and local:
        candidate = Path(local) / 'bin' / ('ffmpeg.exe' if os.name == 'nt' else 'ffmpeg')
        if candidate.exists(): ffmpeg = str(candidate)
    report['checks']['node'] = {'ok': bool(node), 'version': node}
    report['checks']['python'] = {'ok': bool(python), 'version': python}
    report['checks']['ffmpeg'] = {'ok': bool(ffmpeg), 'path': ffmpeg or ''}
    report['ok'] = report['ok'] and bool(node and python and ffmpeg)
    if local:
        remotion = Path(local) / 'node_modules' / '.bin' / ('remotion.cmd' if os.name == 'nt' else 'remotion')
        report['checks']['remotion'] = {'ok': remotion.exists(), 'path': str(remotion)}
        report['ok'] = report['ok'] and remotion.exists()
    if shared:
        worker = Path(shared) / '_workers' / 'keremev.json'
        report['checks']['workerState'] = {'ok': worker.exists(), 'path': str(worker)}
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0 if report['ok'] else 2

if __name__ == '__main__':
    raise SystemExit(main())
