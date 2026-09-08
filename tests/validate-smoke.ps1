$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$validator = Join-Path $root 'scripts/validate.ps1'
if (-not (Test-Path -LiteralPath $validator)) { throw 'Expected validator to exist.' }
$invalid = Join-Path $env:TEMP ("os-empresa-invalid-" + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $invalid | Out-Null
try {
    $failed = & powershell -NoProfile -ExecutionPolicy Bypass -File $validator -Root $invalid 2>&1
    if ($LASTEXITCODE -eq 0) { throw 'Validator accepted an invalid structure' }
    $valid = & powershell -NoProfile -ExecutionPolicy Bypass -File $validator -Root $root 2>&1
    if ($LASTEXITCODE -ne 0 -or ($valid -join "`n") -notmatch 'VALID') { throw "Validator rejected valid root: $valid" }
    Write-Output 'GREEN: validator rejects invalid structure and accepts the demo'
} finally {
    if (Test-Path $invalid) { Remove-Item -LiteralPath $invalid -Recurse -Force }
}
