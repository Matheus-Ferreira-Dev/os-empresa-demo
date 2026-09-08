$ErrorActionPreference = 'Stop'
$root = Join-Path $env:TEMP ("os-empresa-economy-" + [guid]::NewGuid().ToString('N'))
try {
  New-Item -ItemType Directory -Path $root | Out-Null
  & (Join-Path (Split-Path $PSScriptRoot) 'instalar.ps1') -Target $root | Out-Null
  foreach ($script in @('gerar-indice.ps1','compactar-contexto.ps1')) {
    if (-not (Test-Path (Join-Path $root "scripts\$script"))) { throw "missing economy script: $script" }
  }
  & (Join-Path $root 'scripts\novo-cliente.ps1') -Root $root -Name 'Cliente Teste' | Out-Null
  & (Join-Path $root 'scripts\novo-projeto.ps1') -Root $root -Client 'cliente-teste' -Name 'Projeto Teste' -Objective 'validar economia' | Out-Null
  Add-Content (Join-Path $root 'clientes\cliente-teste\projetos\projeto-teste\entregas\privado.md') 'CONTEUDO LONGO QUE NAO DEVE ENTRAR NO RESUMO'
  & (Join-Path $root 'scripts\gerar-indice.ps1') -Root $root | Out-Null
  & (Join-Path $root 'scripts\compactar-contexto.ps1') -Root $root | Out-Null
  $summary = Get-Content (Join-Path $root 'sistema\contexto-minimo.md') -Raw
  if ($summary -match 'CONTEUDO LONGO') { throw 'summary included full delivery content' }
  if ($summary -notmatch 'cliente-teste' -or $summary -notmatch 'projeto-teste') { throw 'summary missed project identity' }
  Write-Host 'GREEN: economy scripts create a compact context without full deliverables'
} finally { if (Test-Path $root) { Remove-Item -LiteralPath $root -Recurse -Force } }
