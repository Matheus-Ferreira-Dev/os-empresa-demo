# Como adicionar uma skill

Uma skill é uma instrução reutilizável para uma capacidade específica. No OS Empresa, ela fica em uma pasta própria e só é carregada quando a tarefa precisa dela.

## Opção 1 — pedir ao criador de skills

Diga ao agente:

```text
Quero uma skill para [tarefa]. Analise o que preciso, proponha o gatilho,
entradas, etapas, saída, critérios de qualidade e limites. Não instale ainda.
```

Revise a proposta em `skills/propostas/`. Depois de aprovar, diga:

```text
Aprovado. Crie a skill seguindo a proposta, valide a estrutura e mostre um caso de teste.
```

O agente deve criar a pasta em `.claude/skills/<slug>/SKILL.md`. A aprovação é obrigatória; uma rotina detectada nunca vira skill automaticamente.

## Opção 2 — criar manualmente

Crie esta estrutura:

```text
.claude/skills/minha-skill/
└── SKILL.md
```

O arquivo precisa começar com `name` e `description`:

```markdown
---
name: minha-skill
description: Explica em uma frase quando esta skill deve ser usada.
---

# Minha skill

## Quando usar

Descreva o pedido que ativa a skill.

## Fluxo

1. Leia somente o manifesto do projeto atual.
2. Execute as etapas em ordem.
3. Salve a saída no projeto, criando uma nova versão.

## Limites

Peça aprovação antes de publicar, enviar mensagens, gastar dinheiro ou usar chaves.
```

Use um `slug` simples, uma ideia por skill e caminhos relativos ao workspace. Não coloque tokens, senhas ou dados de clientes no arquivo.

## Referências e scripts opcionais

Se a skill crescer, mantenha o `SKILL.md` curto e crie `references/` ou `scripts/` dentro da pasta. Explique no `SKILL.md` quando abrir cada arquivo; não carregue tudo de uma vez.

## Validar e testar

Na raiz do OS Empresa, rode:

```powershell
powershell -File .\scripts\validate.ps1 -Root .
```

Depois faça um caso real pequeno, confira os arquivos criados e confirme que clientes/projetos não foram misturados. Se a skill for alterada, teste novamente antes de usá-la em produção.

## Para remover ou atualizar

Atualize o mesmo `SKILL.md` preservando o nome, ou mova a pasta para um local de arquivo. Nunca apague uma skill usada por projetos sem revisar as dependências e registrar a mudança.
