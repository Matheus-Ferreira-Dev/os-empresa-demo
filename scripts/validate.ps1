param(
    [string]$Root = (Get-Location).Path
)

$ErrorActionPreference = 'Stop'
$resolvedRoot = (Resolve-Path -LiteralPath $Root).Path
$failures = [System.Collections.Generic.List[string]]::new()
$checks = 0

function Assert-Check {
    param([string]$Label, [bool]$Condition)
    $script:checks++
    if (-not $Condition) { $script:failures.Add($Label) }
}

$requiredFiles = @('README.md', 'COMECE-AQUI.md', 'AGENTS.md', 'CLAUDE.md')
foreach ($file in $requiredFiles) {
    Assert-Check "arquivo obrigatório: $file" (Test-Path -LiteralPath (Join-Path $resolvedRoot $file) -PathType Leaf)
}

$requiredDirectories = @('.claude/skills', 'templates', 'sistema', 'clientes')
foreach ($directory in $requiredDirectories) {
    Assert-Check "diretório obrigatório: $directory" (Test-Path -LiteralPath (Join-Path $resolvedRoot $directory) -PathType Container)
}

$skillRoot = Join-Path $resolvedRoot '.claude/skills'
$skillFiles = @()
if (Test-Path -LiteralPath $skillRoot -PathType Container) {
    $skillFiles = @(Get-ChildItem -LiteralPath $skillRoot -Directory | ForEach-Object {
        $skillFile = Join-Path $_.FullName 'SKILL.md'
        if (Test-Path -LiteralPath $skillFile -PathType Leaf) { Get-Item -LiteralPath $skillFile }
    })
}
Assert-Check 'pelo menos uma SKILL.md instalada' ($skillFiles.Count -gt 0)

$skillNames = [System.Collections.Generic.List[string]]::new()
foreach ($skillFile in $skillFiles) {
    $content = Get-Content -LiteralPath $skillFile.FullName -Raw
    Assert-Check "frontmatter da skill: $($skillFile.Directory.Name)" ($content -match '(?ms)^---\s*\n.*?^name:\s*[^\r\n]+.*?^description:\s*[^\r\n]+.*?^---')
    $skillNames.Add($skillFile.Directory.Name)
}
Assert-Check 'IDs de skills únicos' (($skillNames | Sort-Object -Unique).Count -eq $skillNames.Count)

$sensitive = @(Get-ChildItem -LiteralPath $resolvedRoot -Recurse -File -Force -ErrorAction SilentlyContinue | Where-Object {
    $_.Name -match '^\.env($|\.)' -or $_.Name -match 'secret'
})
Assert-Check 'nenhum segredo versionável encontrado' ($sensitive.Count -eq 0)

if ($failures.Count -gt 0) {
    Write-Output "INVALID: $($failures.Count) failed checks"
    $failures | ForEach-Object { Write-Output "- $_" }
    exit 1
}

Write-Output "VALID: $checks checks"

