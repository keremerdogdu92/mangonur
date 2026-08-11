# Path: scripts/launch-studio.ps1
# Summary: Runs the Mangonur updater first, then starts Remotion Studio from a machine-local project folder.
param([Parameter(Mandatory = $true)][string]$ProjectId)
$ErrorActionPreference = 'Stop'
$skillHome = [Environment]::GetEnvironmentVariable('MANGONUR_SKILL_HOME', 'User')
$localRoot = [Environment]::GetEnvironmentVariable('MANGONUR_LOCAL_WORKSPACE', 'User')
if (-not $skillHome -or -not $localRoot) { throw 'Mangonur local environment is not configured.' }
$updater = Join-Path $skillHome 'current\scripts\update-skill.ps1'
if (Test-Path -LiteralPath $updater) { & $updater }
$project = Join-Path $localRoot ("projects\\" + $ProjectId + '\\remotion')
if (-not (Test-Path -LiteralPath (Join-Path $project 'package.json'))) { throw "Remotion project not found: $project" }
Push-Location $project
try { npx remotion studio --no-open } finally { Pop-Location }
