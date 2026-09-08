param([string]$Root = (Get-Location).Path)
$ErrorActionPreference = 'Stop'
$clientsRoot = Join-Path $Root 'clientes'
$out = Join-Path $Root 'sistema\indice-contexto.md'
$lines = @('# Indice de contexto', '', 'Use este arquivo para escolher o contexto antes de abrir entregas.', '', '| Cliente | Projeto | Status | Entregas |', '|---|---|---|---|')
foreach ($client in @(Get-ChildItem -LiteralPath $clientsRoot -Directory -ErrorAction SilentlyContinue)) {
  foreach ($project in @(Get-ChildItem -LiteralPath (Join-Path $client.FullName 'projetos') -Directory -ErrorAction SilentlyContinue)) {
    $manifest = Join-Path $project.FullName 'projeto.md'
    $statusLine = (Select-String -LiteralPath $manifest -Pattern 'Status' -ErrorAction SilentlyContinue | Select-Object -First 1).Line
    if (-not $statusLine) { $statusLine = 'pendente' }
    $deliveryCount = @(Get-ChildItem -LiteralPath (Join-Path $project.FullName 'entregas') -File -Recurse -ErrorAction SilentlyContinue).Count
    $lines += "| $($client.Name) | $($project.Name) | $statusLine | $deliveryCount |"
  }
}
$lines | Set-Content -LiteralPath $out
Write-Host "Indice atualizado: $out"
