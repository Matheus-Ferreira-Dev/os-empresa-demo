#!/usr/bin/env bash
set -euo pipefail
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-os-empresa}"
mkdir -p "$TARGET/.claude/skills" "$TARGET/templates" "$TARGET/sistema" "$TARGET/clientes" "$TARGET/historico" "$TARGET/skills/propostas" "$TARGET/skills/criadas-pelo-usuario" "$TARGET/scripts" "$TARGET/projetos-internos" "$TARGET/meu-negocio"
for file in README.md COMECE-AQUI.md AGENTS.md CLAUDE.md LICENSE.txt NOTICE-THIRD-PARTY.md; do
  [ -e "$TARGET/$file" ] || cp "$SOURCE_DIR/$file" "$TARGET/$file"
done
cp -n "$SOURCE_DIR"/templates/* "$TARGET/templates/" 2>/dev/null || true
cp -R -n "$SOURCE_DIR"/templates/entregas "$TARGET/templates/" 2>/dev/null || true
cp -n "$SOURCE_DIR"/sistema/* "$TARGET/sistema/" 2>/dev/null || true
cp -R -n "$SOURCE_DIR"/sistema/modelos "$TARGET/sistema/" 2>/dev/null || true
 [ -e "$TARGET/skills/catalogo.md" ] || cp "$SOURCE_DIR/skills/catalogo.md" "$TARGET/skills/catalogo.md"
cp -R "$SOURCE_DIR/.claude/skills/." "$TARGET/.claude/skills/"
cp -n "$SOURCE_DIR"/scripts/*.ps1 "$TARGET/scripts/" 2>/dev/null || true
if command -v pwsh >/dev/null 2>&1; then pwsh -NoProfile -File "$SOURCE_DIR/scripts/validate.ps1" -Root "$TARGET"; fi
echo "OS Empresa instalado em: $TARGET"
