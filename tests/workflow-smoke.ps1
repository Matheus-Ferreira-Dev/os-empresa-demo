$ErrorActionPreference = 'Stop'
$root = Join-Path $env:TEMP ("os-empresa-flow-" + [guid]::NewGuid().ToString('N'))
try {
  New-Item -ItemType Directory -Path $root | Out-Null
  & (Join-Path (Split-Path $PSScriptRoot) 'instalar.ps1') -Target $root | Out-Null
  & (Join-Path $root 'scripts\novo-cliente.ps1') -Root $root -Name 'Loja Sol' -Type 'servico' | Out-Null
  & (Join-Path $root 'scripts\novo-projeto.ps1') -Root $root -Client 'loja-sol' -Name 'Campanha de inverno' -Objective 'captar contatos' | Out-Null
  $project = Join-Path $root 'clientes\loja-sol\projetos\campanha-de-inverno'
  if (-not (Test-Path (Join-Path $project 'projeto.md'))) { throw 'project manifest missing' }
  & (Join-Path $root 'scripts\criar-carrossel.ps1') -Root $root -Client 'loja-sol' -Project 'campanha-de-inverno' -Topic '3 erros no atendimento' | Out-Null
  & (Join-Path $root 'scripts\criar-landing-page.ps1') -Root $root -Client 'loja-sol' -Project 'campanha-de-inverno' -Offer 'Diagnóstico gratuito' | Out-Null
  if (-not (Get-ChildItem -Recurse -Path (Join-Path $project 'entregas') -Filter 'index.html')) { throw 'landing page missing' }
  & (Join-Path $root 'scripts\painel.ps1') -Root $root | Out-Null
  Write-Host 'GREEN: client, project, carousel, landing page and panel flow works'
} finally { if (Test-Path $root) { Remove-Item -LiteralPath $root -Recurse -Force } }
