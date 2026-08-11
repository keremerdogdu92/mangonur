# Path: scripts/setup-workspace.ps1
# Summary: Configures the shared Google Drive root and machine-local Mangonur workspace, then creates the standard directory structure.
param(
    [Parameter(Mandatory = $true)][string]$SharedRoot,
    [Parameter(Mandatory = $true)][string]$LocalRoot
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $SharedRoot)) { throw "SharedRoot does not exist: $SharedRoot" }
New-Item -ItemType Directory -Force -Path $LocalRoot | Out-Null
[Environment]::SetEnvironmentVariable('MANGONUR_WORKSPACE', $SharedRoot, 'User')
[Environment]::SetEnvironmentVariable('MANGONUR_LOCAL_WORKSPACE', $LocalRoot, 'User')
$shared = @('library\sfx','library\music','library\metadata','projects','_incoming','_exports','_system')
$local = @('projects','shared-cache')
foreach ($relative in $shared) { New-Item -ItemType Directory -Force -Path (Join-Path $SharedRoot $relative) | Out-Null }
foreach ($relative in $local) { New-Item -ItemType Directory -Force -Path (Join-Path $LocalRoot $relative) | Out-Null }
Write-Host "MANGONUR_WORKSPACE=$SharedRoot"
Write-Host "MANGONUR_LOCAL_WORKSPACE=$LocalRoot"
