param([string]$Root = (Get-Location).Path)
$ErrorActionPreference = 'Stop'
$index = Join-Path $Root 'sistema\indice-contexto.md'
if (-not (Test-Path $index)) { & (Join-Path $PSScriptRoot 'gerar-indice.ps1') -Root $Root | Out-Null }
$out = Join-Path $Root 'sistema\contexto-minimo.md'
$lines = @('# Contexto minimo', '', 'Leia este resumo antes dos arquivos completos.', '')
$config = Join-Path $Root 'sistema\configuracao.md'
if (Test-Path $config) { $lines += '## Configuracao'; $lines += @(Get-Content $config | Select-Object -First 8); $lines += '' }
$lines += '## Projetos'; $lines += @(Get-Content $index); $lines += ''
$lines += '## Regra'; $lines += 'Abra somente a skill e os manifestos do projeto escolhido. Entregas completas ficam fora deste resumo.'
$lines | Set-Content -LiteralPath $out
Write-Host "Contexto minimo criado: $out"
