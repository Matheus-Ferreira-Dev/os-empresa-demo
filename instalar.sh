#!/usr/bin/env bash
set -euo pipefail
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-os-empresa}"
mkdir -p "$TARGET/.claude/skills" "$TARGET/templates" "$TARGET/sistema" "$TARGET/clientes" "$TARGET/historico" "$TARGET/skills"
for file in README.md COMECE-AQUI.md AGENTS.md CLAUDE.md LICENSE.txt NOTICE-THIRD-PARTY.md; do
  [ -e "$TARGET/$file" ] || cp "$SOURCE_DIR/$file" "$TARGET/$file"
done
for file in "$SOURCE_DIR"/templates/*; do [ -e "$file" ] || continue; name="${file##*/}"; [ -e "$TARGET/templates/$name" ] || cp "$file" "$TARGET/templates/$name"; done
for file in "$SOURCE_DIR"/sistema/*; do [ -e "$file" ] || continue; name="${file##*/}"; [ -e "$TARGET/sistema/$name" ] || cp "$file" "$TARGET/sistema/$name"; done
cp -R "$SOURCE_DIR/.claude/skills/." "$TARGET/.claude/skills/"
if command -v pwsh >/dev/null 2>&1; then pwsh -NoProfile -File "$SOURCE_DIR/scripts/validate.ps1" -Root "$TARGET"; fi
echo "OS Empresa instalado em: $TARGET"
