$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$validator = Join-Path $root 'scripts/validate.ps1'
if (-not (Test-Path -LiteralPath $validator)) {
    Write-Error 'Expected validator to exist and report a missing structure.'
    exit 1
}

$output = & powershell -NoProfile -ExecutionPolicy Bypass -File $validator -Root $root 2>&1
if ($LASTEXITCODE -eq 0) { throw "Expected the validator to fail before the project structure exists. Output: $output" }

Write-Output 'RED: validator correctly fails before the project structure exists'
