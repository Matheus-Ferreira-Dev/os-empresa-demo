# Roteiro de teste (15 minutos)

1. Clone o repositório privado e rode `./instalar.ps1 -Target ./demo`.
2. Abra `demo/COMECE-AQUI.md`.
3. Rode os scripts ou peça ao agente:
   - novo cliente `Loja Sol`;
   - projeto `Campanha de inverno`;
   - carrossel sobre atendimento;
   - landing page para uma oferta.
4. Confira se cada saída ficou dentro do cliente/projeto correto.
5. Rode `demo/scripts/painel.ps1 -Root demo`.
6. Faça uma tarefa repetida três vezes no arquivo `demo/historico/eventos.jsonl` e rode `demo/scripts/detectar-rotinas.ps1 -Root demo`. A proposta deve aparecer em `demo/skills/propostas/` sem instalar uma skill automaticamente.

Envie feedback sobre clareza, organização, utilidade e o que você esperaria automatizar depois. Não use chaves de API nesta prévia.
