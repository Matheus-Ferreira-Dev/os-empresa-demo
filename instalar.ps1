param(
    [string]$Target = (Join-Path (Get-Location) 'os-empresa')
)

$ErrorActionPreference = 'Stop'
$Source = Split-Path -Parent $MyInvocation.MyCommand.Path
$directories = @(
    '.claude\skills', 'templates', 'sistema', 'clientes', 'historico', 'skills', 'skills\propostas', 'skills\criadas-pelo-usuario', 'scripts', 'projetos-internos', 'meu-negocio'
)

New-Item -ItemType Directory -Force -Path $Target | Out-Null
foreach ($relative in $directories) {
    New-Item -ItemType Directory -Force -Path (Join-Path $Target $relative) | Out-Null
}

$files = @('README.md', 'COMECE-AQUI.md', 'TESTE-PARA-AMIGO.md', 'AGENTS.md', 'CLAUDE.md', 'LICENSE.txt', 'NOTICE-THIRD-PARTY.md')
foreach ($file in $files) {
    $destination = Join-Path $Target $file
    if (-not (Test-Path -LiteralPath $destination)) {
        Copy-Item -LiteralPath (Join-Path $Source $file) -Destination $destination
    }
}

foreach ($folder in @('templates', 'sistema')) {
    Get-ChildItem -LiteralPath (Join-Path $Source $folder) -File -Recurse | ForEach-Object {
        $relative = $_.FullName.Substring((Join-Path $Source $folder).Length).TrimStart('\','/')
        $destination = Join-Path (Join-Path $Target $folder) $relative
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $destination) | Out-Null
        if (-not (Test-Path -LiteralPath $destination)) { Copy-Item -LiteralPath $_.FullName -Destination $destination }
    }
}
if (-not (Test-Path (Join-Path $Target 'skills\catalogo.md'))) {
    Copy-Item -LiteralPath (Join-Path $Source 'skills\catalogo.md') -Destination (Join-Path $Target 'skills\catalogo.md')
}
Get-ChildItem -LiteralPath (Join-Path $Source '.claude\skills') -Directory | ForEach-Object {
    $destination = Join-Path (Join-Path $Target '.claude\skills') $_.Name
    Copy-Item -LiteralPath $_.FullName -Destination $destination -Recurse -Force
}
Get-ChildItem -LiteralPath (Join-Path $Source 'scripts') -File -Filter '*.ps1' | ForEach-Object {
    $destination = Join-Path (Join-Path $Target 'scripts') $_.Name
    if (-not (Test-Path -LiteralPath $destination)) { Copy-Item -LiteralPath $_.FullName -Destination $destination }
}

$validator = Join-Path $Source 'scripts\validate.ps1'
if (Test-Path -LiteralPath $validator) {
    & $validator -Root $Target
}
Write-Host "OS Empresa instalado em: $Target"
