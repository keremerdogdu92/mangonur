# Path: scripts/launch-tools-panel.ps1
# Summary: Starts the loopback-only Mangonur Audio & Finishing panel for a local Windows project after validating required workspace paths.
param([Parameter(Mandatory = $true)][string]$ProjectId)
$ErrorActionPreference = 'Stop'
$localRoot = [Environment]::GetEnvironmentVariable('MANGONUR_LOCAL_WORKSPACE', 'User')
$skillHome = [Environment]::GetEnvironmentVariable('MANGONUR_SKILL_HOME', 'User')
if (-not $localRoot -or -not $skillHome) { throw 'Mangonur local environment is not configured.' }
$projectRoot = Join-Path $localRoot ("projects\" + $ProjectId)
if (-not (Test-Path -LiteralPath $projectRoot -PathType Container)) { throw "Project not found: $projectRoot" }
$server = Join-Path $skillHome 'current\templates\tools-panel\server.mjs'
if (-not (Test-Path -LiteralPath $server -PathType Leaf)) { throw "Mangonur tools server not found: $server" }
$env:MANGONUR_PROJECT_ROOT = $projectRoot
node $server
