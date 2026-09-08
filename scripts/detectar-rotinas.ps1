param([string]$Root = (Get-Location).Path)
$ErrorActionPreference = 'Stop'
$eventsFile = Join-Path $Root 'historico\eventos.jsonl'
if (-not (Test-Path $eventsFile)) { Write-Host 'Nenhum evento registrado.'; exit 0 }
$events = @(Get-Content $eventsFile | ForEach-Object { try { $_ | ConvertFrom-Json } catch {} })
$groups = $events | Group-Object intent | Where-Object { $_.Count -ge 3 }
$proposalDir = Join-Path $Root 'skills\propostas'; New-Item -ItemType Directory -Force -Path $proposalDir | Out-Null
foreach ($group in $groups) {
  $slug = ($group.Name.ToLowerInvariant() -replace '[^a-z0-9 ]','' -replace '\s+','-')
  $file = Join-Path $proposalDir "rotina-$slug.md"
  if (-not (Test-Path $file)) {
    @("# Proposta de skill: $($group.Name)", '', "Foram detectados $($group.Count) eventos equivalentes.", '', '## Problema', 'Esta rotina parece repetitiva e pode virar uma skill.', '', '## Revisão humana obrigatória', '- confirmar entradas e saídas', '- definir limites e permissões', '- aprovar antes de instalar') | Set-Content $file
    Write-Host "Proposta criada: $file"
  }
}
if ($groups.Count -eq 0) { Write-Host 'Nenhuma rotina atingiu 3 repetições.' }
