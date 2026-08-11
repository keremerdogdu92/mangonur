# Path: scripts/new-project.ps1
# Summary: Creates matching durable and local project folders using a stable project ID without placing Remotion caches in Google Drive.
param([Parameter(Mandatory = $true)][string]$ProjectId)
$ErrorActionPreference = 'Stop'
$sharedRoot = [Environment]::GetEnvironmentVariable('MANGONUR_WORKSPACE', 'User')
$localRoot = [Environment]::GetEnvironmentVariable('MANGONUR_LOCAL_WORKSPACE', 'User')
if (-not $sharedRoot -or -not $localRoot) { throw 'Mangonur workspace environment variables are not configured.' }
if ($ProjectId -notmatch '^[a-zA-Z0-9][a-zA-Z0-9._-]+$') { throw 'ProjectId contains unsupported characters.' }
$sharedProject = Join-Path $sharedRoot ("projects\" + $ProjectId)
$localProject = Join-Path $localRoot ("projects\" + $ProjectId)
@('script','visuals','narration','alignment','audio_candidates','audio_selected','manifests','renders\review','renders\final') | ForEach-Object { New-Item -ItemType Directory -Force -Path (Join-Path $sharedProject $_) | Out-Null }
@('remotion','working','temp','cache') | ForEach-Object { New-Item -ItemType Directory -Force -Path (Join-Path $localProject $_) | Out-Null }
Write-Host "Shared project: $sharedProject"
Write-Host "Local project:  $localProject"
