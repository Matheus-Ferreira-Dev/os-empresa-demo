---
name: central-de-trabalho
description: Identifica o contexto atual, roteia a intenção e mantém o painel de clientes, projetos e entregas atualizado.
---

# Central de trabalho

1. Leia `sistema/configuracao.md`.
2. Resolva o contexto nesta ordem: cliente explícito, projeto explícito, último projeto mencionado. Se houver ambiguidade, pergunte antes de criar.
3. Roteie para a skill específica: cadastro, carrossel, página ou criação de skill.
4. Ao terminar, atualize o status no manifesto e registre um evento resumido em `historico/eventos.jsonl`.

Responda sempre com: contexto usado, arquivos criados/alterados e próxima ação. Não faça chamadas externas nesta prévia.
