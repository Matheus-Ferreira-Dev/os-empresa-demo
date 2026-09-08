param([string]$Root = (Get-Location).Path, [Parameter(Mandatory)][string]$Client, [Parameter(Mandatory)][string]$Project, [Parameter(Mandatory)][string]$Topic)
$ErrorActionPreference = 'Stop'
$base = Join-Path $Root "clientes\$Client\projetos\$Project\entregas\carrosseis"
New-Item -ItemType Directory -Force -Path $base | Out-Null
$n = 1; while (Test-Path (Join-Path $base "$($Topic.ToLowerInvariant() -replace '[^a-z0-9 ]','' -replace '\s+','-')-v$n")) { $n++ }
$out = Join-Path $base "$($Topic.ToLowerInvariant() -replace '[^a-z0-9 ]','' -replace '\s+','-')-v$n"; New-Item -ItemType Directory -Path $out | Out-Null
@("# Roteiro: $Topic", '', '## Slide 1 — Gancho', "Uma pergunta ou promessa sobre $Topic.", '', '## Slide 2 — Problema', 'Mostre o erro de forma concreta.', '', '## Slide 3 — Caminho', 'Explique a primeira ação prática.', '', '## Slide 4 — Exemplo', 'Inclua uma prova ou exemplo do cliente.', '', '## Slide 5 — CTA', 'Convide a pessoa para o próximo passo.') | Set-Content (Join-Path $out 'roteiro.md')
@("# Legenda: $Topic", '', "Gancho relacionado a $Topic.", '', 'Aqui está o contexto e a orientação principal.', '', '**CTA:** peça uma ação simples e mensurável.') | Set-Content (Join-Path $out 'legenda.md')
@('# Checklist', '', '- [ ] uma ideia por slide', '- [ ] CTA claro', '- [ ] revisão do cliente') | Set-Content (Join-Path $out 'checklist.md')
Write-Host "Carrossel criado: $out"
