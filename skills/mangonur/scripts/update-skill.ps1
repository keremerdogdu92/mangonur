# Path: scripts/update-skill.ps1
# Summary: Updates a local Mangonur skill installation from the shared Drive release channel using SHA-256 verification and staged version folders.
param([switch]$Force)
$ErrorActionPreference = 'Stop'
$sharedRoot = [Environment]::GetEnvironmentVariable('MANGONUR_WORKSPACE', 'User')
$skillHome = [Environment]::GetEnvironmentVariable('MANGONUR_SKILL_HOME', 'User')
if (-not $sharedRoot -or -not $skillHome) { throw 'MANGONUR_WORKSPACE and MANGONUR_SKILL_HOME must be configured.' }
$channelRoot = Join-Path $sharedRoot '_system\skill'
$manifestPath = Join-Path $channelRoot 'manifest.json'
if (-not (Test-Path -LiteralPath $manifestPath)) { throw "Release manifest not found: $manifestPath" }
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
if (-not $manifest.latestVersion -or -not $manifest.archive -or -not $manifest.sha256) { throw 'Release manifest is incomplete.' }
$statePath = Join-Path $skillHome 'state.json'
$currentVersion = $null
if (Test-Path -LiteralPath $statePath) { $currentVersion = (Get-Content -LiteralPath $statePath -Raw | ConvertFrom-Json).version }
if (-not $Force -and $currentVersion -eq $manifest.latestVersion) { Write-Host "Mangonur is current: $currentVersion"; exit 0 }
$archiveSource = Join-Path $channelRoot $manifest.archive
if (-not (Test-Path -LiteralPath $archiveSource)) { throw "Release archive not available locally yet: $archiveSource" }
$downloads = Join-Path $skillHome 'downloads'
$versions = Join-Path $skillHome 'versions'
New-Item -ItemType Directory -Force -Path $downloads,$versions | Out-Null
$archiveLocal = Join-Path $downloads ("mangonur-" + $manifest.latestVersion + '.zip')
Copy-Item -LiteralPath $archiveSource -Destination $archiveLocal -Force
$actualHash = (Get-FileHash -LiteralPath $archiveLocal -Algorithm SHA256).Hash.ToLowerInvariant()
if ($actualHash -ne ([string]$manifest.sha256).ToLowerInvariant()) { throw 'Release SHA-256 verification failed.' }
$stage = Join-Path $versions ('.staging-' + $manifest.latestVersion + '-' + [Guid]::NewGuid().ToString('N'))
Expand-Archive -LiteralPath $archiveLocal -DestinationPath $stage -Force
$skillFile = Join-Path $stage 'mangonur\SKILL.md'
if (-not (Test-Path -LiteralPath $skillFile)) { Remove-Item -LiteralPath $stage -Recurse -Force; throw 'Release archive is missing mangonur/SKILL.md.' }
$versionPath = Join-Path $versions $manifest.latestVersion
if (Test-Path -LiteralPath $versionPath) { Remove-Item -LiteralPath $versionPath -Recurse -Force }
Move-Item -LiteralPath $stage -Destination $versionPath
$currentPath = Join-Path $skillHome 'current'
$backupPath = Join-Path $skillHome 'previous'
if (Test-Path -LiteralPath $backupPath) { Remove-Item -LiteralPath $backupPath -Recurse -Force }
if (Test-Path -LiteralPath $currentPath) { Move-Item -LiteralPath $currentPath -Destination $backupPath }
Copy-Item -LiteralPath (Join-Path $versionPath 'mangonur') -Destination $currentPath -Recurse -Force
@{version=$manifest.latestVersion;updatedAt=(Get-Date).ToString('o')} | ConvertTo-Json | Set-Content -LiteralPath $statePath -Encoding utf8
Write-Host "Mangonur updated to $($manifest.latestVersion)"
