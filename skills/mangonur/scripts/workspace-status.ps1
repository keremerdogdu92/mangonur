# Path: scripts/workspace-status.ps1
# Summary: Validates Mangonur workspace environment variables, directory availability, and basic read/write access without exposing credentials.
$ErrorActionPreference = 'Stop'
$sharedRoot = [Environment]::GetEnvironmentVariable('MANGONUR_WORKSPACE', 'User')
$localRoot = [Environment]::GetEnvironmentVariable('MANGONUR_LOCAL_WORKSPACE', 'User')
foreach ($item in @(@{Name='Shared';Path=$sharedRoot}, @{Name='Local';Path=$localRoot})) {
    if (-not $item.Path) { Write-Host "$($item.Name): NOT CONFIGURED"; continue }
    $exists = Test-Path -LiteralPath $item.Path
    Write-Host "$($item.Name): $($item.Path) | Exists=$exists"
    if ($exists) {
        $probe = Join-Path $item.Path '.mangonur-write-test.tmp'
        try { Set-Content -LiteralPath $probe -Value 'ok' -Encoding ascii; Remove-Item -LiteralPath $probe -Force; Write-Host '  WriteTest=OK' }
        catch { Write-Host "  WriteTest=FAILED: $($_.Exception.Message)" }
    }
}
