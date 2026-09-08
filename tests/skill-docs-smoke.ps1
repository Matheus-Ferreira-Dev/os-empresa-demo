$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$doc = Join-Path $root 'COMO-ADICIONAR-SKILL.md'
if (-not (Test-Path -LiteralPath $doc)) { throw 'Skill installation guide is missing' }
$text = Get-Content -LiteralPath $doc -Raw
foreach ($term in @('SKILL.md', '.claude/skills', 'name:', 'description:', 'aprovação', 'teste')) {
  if ($text -notmatch [regex]::Escape($term)) { throw "Guide missing: $term" }
}
Write-Host 'GREEN: skill installation guide covers structure, approval and testing'
