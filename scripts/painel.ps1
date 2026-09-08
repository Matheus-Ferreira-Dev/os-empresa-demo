param([string]$Root = (Get-Location).Path)
$ErrorActionPreference = 'Stop'
Write-Host "# Painel OS Empresa`n"
$clients = Get-ChildItem -LiteralPath (Join-Path $Root 'clientes') -Directory -ErrorAction SilentlyContinue
foreach ($client in $clients) {
  Write-Host "## $($client.Name)"
  $projects = Get-ChildItem -LiteralPath (Join-Path $client.FullName 'projetos') -Directory -ErrorAction SilentlyContinue
  foreach ($project in $projects) {
    $manifest = Join-Path $project.FullName 'projeto.md'
    $status = (Select-String -LiteralPath $manifest -Pattern 'Status' -ErrorAction SilentlyContinue | Select-Object -First 1).Line
    $count = @(Get-ChildItem -LiteralPath (Join-Path $project.FullName 'entregas') -File -Recurse -ErrorAction SilentlyContinue).Count
    Write-Host "- $($project.Name) | $status | arquivos de entrega: $count"
  }
}
