# Path: scripts/setup-updater.ps1
# Summary: Configures the machine-local Mangonur skill home used by the verified release updater.
param([Parameter(Mandatory = $true)][string]$SkillHome)
$ErrorActionPreference = 'Stop'
New-Item -ItemType Directory -Force -Path $SkillHome | Out-Null
[Environment]::SetEnvironmentVariable('MANGONUR_SKILL_HOME', $SkillHome, 'User')
@('versions','downloads') | ForEach-Object { New-Item -ItemType Directory -Force -Path (Join-Path $SkillHome $_) | Out-Null }
Write-Host "MANGONUR_SKILL_HOME=$SkillHome"
