$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$expected = @('onboarding', 'central-de-trabalho', 'clientes-e-projetos', 'conteudo-e-carrosseis', 'sites-e-landing-pages', 'criador-de-skills')
$missing = @($expected | Where-Object { -not (Test-Path -LiteralPath (Join-Path $root ".claude\skills\$_\SKILL.md")) })
if ($missing.Count -gt 0) {
    Write-Host "RED: missing skills: $($missing -join ', ')"
    exit 1
}
foreach ($skill in $expected) {
    $text = Get-Content -LiteralPath (Join-Path $root ".claude\skills\$skill\SKILL.md") -Raw
    if ($text -notmatch '(?m)^name:\s*' -or $text -notmatch '(?m)^description:\s*') { throw "Invalid frontmatter: $skill" }
}
Write-Host "GREEN: $($expected.Count) core skills are available"
