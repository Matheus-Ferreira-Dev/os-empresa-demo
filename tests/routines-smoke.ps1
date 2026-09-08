$ErrorActionPreference = 'Stop'
$root = Join-Path $env:TEMP ("os-empresa-routines-" + [guid]::NewGuid().ToString('N'))
try {
  New-Item -ItemType Directory -Path $root | Out-Null
  & (Join-Path (Split-Path $PSScriptRoot) 'instalar.ps1') -Target $root | Out-Null
  $events = Join-Path $root 'historico\eventos.jsonl'
  1..3 | ForEach-Object { Add-Content $events '{"intent":"relatorio","date":"2026-09-07"}' }
  & (Join-Path $root 'scripts\detectar-rotinas.ps1') -Root $root | Out-Null
  if (-not (Test-Path (Join-Path $root 'skills\propostas\rotina-relatorio.md'))) { throw 'routine proposal missing' }
  Write-Host 'GREEN: repetition creates a reviewable skill proposal'
} finally { if (Test-Path $root) { Remove-Item -LiteralPath $root -Recurse -Force } }
