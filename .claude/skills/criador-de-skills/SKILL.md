---
name: criador-de-skills
description: Propõe, documenta e instala novas skills a partir de necessidades repetidas, com revisão humana.
---

# Criador de skills

Quando o usuário pedir uma nova capacidade, escreva primeiro uma proposta em `skills/propostas/<slug>.md` com problema, gatilho, entradas, saídas, limites, exemplos e dependências. Oriente a pessoa por `COMO-ADICIONAR-SKILL.md`. Só crie `.claude/skills/<slug>/SKILL.md` após aprovação explícita.

Quando detectar repetição, consulte `historico/eventos.jsonl`: sugira uma skill depois de pelo menos 3 eventos equivalentes em 30 dias. Nunca instale automaticamente. Use frontmatter com `name` e `description`, instruções curtas e referências sob demanda.
