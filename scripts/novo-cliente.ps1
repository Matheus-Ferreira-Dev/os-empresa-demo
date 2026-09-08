param([string]$Root = (Get-Location).Path, [Parameter(Mandatory)][string]$Name, [string]$Type = 'negocio', [string]$Objective = 'A definir')
$ErrorActionPreference = 'Stop'
$slug = (($Name.ToLowerInvariant() -replace '[^a-z0-9áéíóúãõç ]','') -replace '\s+','-')
$path = Join-Path $Root "clientes\$slug"
New-Item -ItemType Directory -Force -Path (Join-Path $path 'projetos') | Out-Null
$file = Join-Path $path 'cliente.md'
if (-not (Test-Path $file)) {
  @("# Cliente: $Name", '', "- **Tipo:** $Type", '- **Contato:** pendente', "- **Objetivo principal:** $Objective", '- **Status:** ativo', '', '## Contexto', '', 'Preencha informações relevantes.') | Set-Content $file
}
Write-Host "Cliente criado: $slug"
