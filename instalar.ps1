param(
    [string]$Target = (Join-Path (Get-Location) 'os-empresa')
)

$ErrorActionPreference = 'Stop'
$Source = Split-Path -Parent $MyInvocation.MyCommand.Path
$directories = @(
    '.claude\skills', 'templates', 'sistema', 'clientes', 'historico', 'skills'
)

New-Item -ItemType Directory -Force -Path $Target | Out-Null
foreach ($relative in $directories) {
    New-Item -ItemType Directory -Force -Path (Join-Path $Target $relative) | Out-Null
}

$files = @('README.md', 'COMECE-AQUI.md', 'AGENTS.md', 'CLAUDE.md', 'LICENSE.txt', 'NOTICE-THIRD-PARTY.md')
foreach ($file in $files) {
    $destination = Join-Path $Target $file
    if (-not (Test-Path -LiteralPath $destination)) {
        Copy-Item -LiteralPath (Join-Path $Source $file) -Destination $destination
    }
}

Get-ChildItem -LiteralPath (Join-Path $Source 'templates') -File | ForEach-Object {
    $destination = Join-Path (Join-Path $Target 'templates') $_.Name
    if (-not (Test-Path -LiteralPath $destination)) { Copy-Item -LiteralPath $_.FullName -Destination $destination }
}
Get-ChildItem -LiteralPath (Join-Path $Source 'sistema') -File | ForEach-Object {
    $destination = Join-Path (Join-Path $Target 'sistema') $_.Name
    if (-not (Test-Path -LiteralPath $destination)) { Copy-Item -LiteralPath $_.FullName -Destination $destination }
}
Get-ChildItem -LiteralPath (Join-Path $Source '.claude\skills') -Directory | ForEach-Object {
    $destination = Join-Path (Join-Path $Target '.claude\skills') $_.Name
    Copy-Item -LiteralPath $_.FullName -Destination $destination -Recurse -Force
}

$validator = Join-Path $Source 'scripts\validate.ps1'
if (Test-Path -LiteralPath $validator) {
    & $validator -Root $Target
}
Write-Host "OS Empresa instalado em: $Target"
