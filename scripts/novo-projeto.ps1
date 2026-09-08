param([string]$Root = (Get-Location).Path, [Parameter(Mandatory)][string]$Client, [Parameter(Mandatory)][string]$Name, [Parameter(Mandatory)][string]$Objective)
$ErrorActionPreference = 'Stop'
$path = Join-Path $Root "clientes\$Client\projetos\$($Name.ToLowerInvariant() -replace '[^a-z0-9 ]','' -replace '\s+','-')"
if (-not (Test-Path (Join-Path $Root "clientes\$Client\cliente.md"))) { throw "Cliente não encontrado: $Client" }
New-Item -ItemType Directory -Force -Path (Join-Path $path 'entregas') | Out-Null
$file = Join-Path $path 'projeto.md'
if (-not (Test-Path $file)) { @("# Projeto: $Name", '', "- **Cliente:** $Client", "- **Objetivo:** $Objective", '- **Status:** planejamento', '', '## Briefing', '', 'Preencha detalhes antes da produção.') | Set-Content $file }
Write-Host "Projeto criado: $path"
