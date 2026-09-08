#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-$(pwd)}"
failures=()
checks=0

check() {
  checks=$((checks + 1))
  if [[ "$2" != "true" ]]; then failures+=("$1"); fi
}

for file in README.md COMECE-AQUI.md AGENTS.md CLAUDE.md; do
  [[ -f "$ROOT/$file" ]] && ok=true || ok=false
  check "arquivo obrigatório: $file" "$ok"
done

for directory in .claude/skills templates sistema clientes; do
  [[ -d "$ROOT/$directory" ]] && ok=true || ok=false
  check "diretório obrigatório: $directory" "$ok"
done

skill_files=()
if [[ -d "$ROOT/.claude/skills" ]]; then
  while IFS= read -r file; do skill_files+=("$file"); done < <(find "$ROOT/.claude/skills" -mindepth 2 -maxdepth 2 -type f -name SKILL.md)
fi
[[ "${#skill_files[@]}" -gt 0 ]] && ok=true || ok=false
check "pelo menos uma SKILL.md instalada" "$ok"

skill_names=()
for file in "${skill_files[@]}"; do
  grep -qE '^name:[[:space:]]*[^[:space:]]' "$file" && grep -qE '^description:[[:space:]]*[^[:space:]]' "$file" && ok=true || ok=false
  check "frontmatter da skill: $(basename "$(dirname "$file")")" "$ok"
  skill_names+=("$(basename "$(dirname "$file")")")
done
unique_names=$(printf '%s\n' "${skill_names[@]}" | sort -u | wc -l | tr -d ' ')
[[ "$unique_names" == "${#skill_names[@]}" ]] && ok=true || ok=false
check 'IDs de skills únicos' "$ok"

if find "$ROOT" -type f \( -name '.env' -o -name '.env.*' -o -iname '*secret*' \) -print -quit | grep -q .; then ok=false; else ok=true; fi
check 'nenhum segredo versionável encontrado' "$ok"

if ((${#failures[@]} > 0)); then
  printf 'INVALID: %s failed checks\n' "${#failures[@]}"
  printf -- '- %s\n' "${failures[@]}"
  exit 1
fi

printf 'VALID: %s checks\n' "$checks"

