# Economia de contexto

O demo usa economia por instrução: lê manifestos primeiro, abre apenas a skill necessária e registra eventos em uma linha. Os scripts `gerar-indice.ps1` e `compactar-contexto.ps1` criam um mapa curto para evitar enviar entregas inteiras ao modelo. Não há daemon nem dependência de API.

## Fluxo recomendado

1. Rode `scripts/gerar-indice.ps1 -Root .` depois de criar ou alterar projetos.
2. Rode `scripts/compactar-contexto.ps1 -Root .` antes de iniciar uma sessão longa.
3. Carregue `sistema/contexto-minimo.md`, depois apenas o manifesto e a skill da tarefa.
4. Use resposta curta por padrão; peça modo normal ou detalhado quando necessário.

Em uma versão futura, adaptadores opcionais poderão filtrar saídas de terminal (RTK), reduzir código redundante (Ponytail) ou experimentar um modo econômico (Caveman). Essas ferramentas não são pré-instaladas porque aumentam a superfície de dependências, podem ter licenças distintas e só ajudam quando o fluxo realmente precisa delas.
