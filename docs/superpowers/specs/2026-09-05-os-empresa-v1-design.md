# OS Empresa — arquitetura do produto e fundação da V1

**Data:** 2026-09-05  
**Status:** proposta consolidada para revisão  
**Nome:** “OS Empresa” é o nome técnico de trabalho; a marca comercial será definida separadamente e não altera esta arquitetura.

## 1. Objetivo

Criar um sistema operacional de negócio baseado em pasta, operado por agentes de IA, que ajude pessoas não técnicas a organizar e executar trabalho empresarial. A primeira versão deve ser simples de instalar, clara no uso diário e preparada para evoluir para um aplicativo sem mudar o formato dos dados.

O produto será criado do zero. O MazyOS serve apenas como referência conceitual pública; nenhum arquivo, texto ou implementação dele será copiado, pois o repositório consultado não apresenta uma licença de reutilização.

## 2. Público e promessa

### Públicos prioritários

- Donos de pequenos negócios e prestadores de serviços.
- Pessoas que oferecem ou querem começar a oferecer serviços digitais com IA.
- Operadores que administram projetos para vários clientes.

### Promessa

O sistema reduz a distância entre “não sei fazer” e “entrega pronta”. Ele não apenas responde: orienta, prepara, executa, verifica, organiza e aprende com o trabalho.

### Modos de operação

1. **Meu Negócio:** opera a própria empresa, seus projetos, conteúdo e documentos.
2. **Prestador/Agência:** administra clientes, projetos, entregas, aprovações e histórico.

Os dois modos usam o mesmo núcleo. O modo escolhido apenas adapta o onboarding, os exemplos e a navegação inicial.

## 3. Escopo da V1

### Incluído

- Onboarding guiado e documentação “comece aqui”.
- Memória em camadas: sistema, negócio, cliente e projeto.
- Criação e gerenciamento de vários clientes e projetos.
- Registro de entregas com status, versão e aprovação.
- Painel em Markdown com próximas ações, projetos e pendências.
- Oito skills essenciais instaladas.
- Catálogo de skills e capacidades opcionais.
- Criação guiada de novas skills.
- Registro de atividades repetidas e sugestão de transformá-las em skill.
- Carregamento seletivo de contexto e modo econômico.
- Adaptadores leves para Claude Code e Codex.
- Validação estrutural, cenários de teste e documentação de recuperação.

### Fora da V1

- Aplicativo gráfico completo.
- Marketplace com pagamentos.
- Colaboração simultânea entre vários usuários.
- Publicação autônoma de anúncios ou uso de orçamento sem aprovação.
- Instalação automática de todas as capacidades externas.
- Serviço hospedado e sincronização em nuvem próprios.

Esses itens ficam preservados como evolução, sem aumentar a complexidade da primeira entrega.

## 4. Princípios de produto

1. **Clareza antes de poder:** a próxima ação deve ser óbvia para uma pessoa leiga.
2. **Começar pequeno:** instalar somente o núcleo e as skills essenciais.
3. **Progressive disclosure:** carregar detalhes, referências e capacidades apenas quando necessários.
4. **Uma fonte canônica:** dados do negócio não devem ser duplicados em vários projetos.
5. **Contexto isolado:** um cliente nunca contamina a memória ou a entrega de outro.
6. **Aprovação humana:** publicação, envio, gastos e alterações sensíveis exigem confirmação.
7. **Resultado verificável:** toda skill define o que constitui uma entrega válida.
8. **Portabilidade:** o conteúdo do usuário permanece em arquivos legíveis e exportáveis.
9. **Evolução compatível:** o aplicativo futuro consumirá os mesmos manifests e artefatos.

## 5. Arquitetura da pasta

```text
os-empresa/
├── COMECE-AQUI.md
├── AGENTS.md
├── CLAUDE.md
├── painel.md
├── meu-negocio/
│   ├── negocio.md
│   ├── estrategia.md
│   ├── preferencias.md
│   └── identidade/
├── clientes/
│   └── <cliente-id>/
│       ├── cliente.md
│       ├── memoria.md
│       ├── identidade/
│       └── projetos/
│           └── <projeto-id>/
│               ├── projeto.md
│               ├── briefing/
│               ├── entregas/
│               │   ├── carrosseis/
│               │   ├── paginas/
│               │   ├── videos/
│               │   ├── textos/
│               │   ├── imagens/
│               │   ├── documentos/
│               │   └── relatorios/
│               ├── aprovacoes/
│               ├── fontes/
│               └── historico/
├── projetos-internos/
├── skills/
│   ├── instaladas/
│   ├── catalogo/
│   ├── compartilhadas/
│   └── criadas-pelo-usuario/
├── capacidades/
│   ├── catalogo.md
│   └── instaladas.md
├── conectores/
│   ├── catalogo.md
│   └── configuracoes/
├── playbooks/
├── sistema/
│   ├── configuracao.md
│   ├── indices/
│   ├── historico/
│   ├── modelos/
│   ├── validacao/
│   └── economia/
└── docs/
```

Pastas de entrega só são criadas quando o projeto precisa delas. A árvore acima documenta os destinos possíveis, não obriga cada projeto a conter diretórios vazios.

## 6. Modelo de informação

### Cliente

`cliente.md` guarda dados reutilizáveis entre todos os projetos daquele cliente: objetivo, oferta, público, canais, contatos autorizados e referências. A identidade visual e a memória ficam ao lado e nunca são copiadas para cada projeto.

### Projeto

`projeto.md` contém frontmatter legível por pessoas e máquinas:

```yaml
---
id: site-institucional
cliente: clinica-vida
objetivo: Publicar o novo site institucional da clínica
status: ativo
prioridade: alta
criado_em: 2026-09-05
atualizado_em: 2026-09-05
---
```

Estados permitidos para projetos: `planejado`, `ativo`, `pausado`, `concluido` e `arquivado`.

### Entrega

Cada entrega começa com frontmatter equivalente:

```yaml
---
id: pagina-inicial-v1
cliente: clinica-vida
projeto: site-institucional
tipo: pagina
status: aguardando-aprovacao
versao: 1
skill: sites-e-landing-pages
criado_em: 2026-09-05
---
```

Estados permitidos para entregas: `rascunho`, `em-revisao`, `aguardando-aprovacao`, `aprovado`, `publicado`, `entregue` e `arquivado`.

Uma entrega aprovada, publicada ou entregue nunca é sobrescrita. Qualquer mudança cria uma nova versão.

## 7. Experiência principal

O usuário pode escrever em linguagem natural. Os nomes abaixo são intenções reconhecidas, não uma sintaxe rígida:

- “configurar meu negócio”;
- “criar cliente”;
- “criar projeto”;
- “abrir projeto”;
- “mostrar meu painel”;
- “o que faço agora?”;
- “continuar de onde parei”;
- “criar carrossel”;
- “criar landing page”;
- “criar proposta”;
- “analisar arquivo”;
- “criar uma nova skill”;
- “ver oportunidades de automação”.

O painel mostra somente informações acionáveis: projetos ativos, entregas aguardando aprovação, prazos próximos, bloqueios e três próximas ações recomendadas.

## 8. Contexto e fluxo de dados

Para cada tarefa, o sistema carrega nesta ordem:

```text
regras mínimas do sistema
        ↓
dados do negócio do usuário
        ↓
cliente ativo, quando houver
        ↓
projeto ativo, quando houver
        ↓
skill escolhida
        ↓
referências específicas solicitadas pela skill
```

O sistema não lê todos os clientes, projetos, skills e históricos em cada conversa. O painel usa índices resumidos; o conteúdo completo é aberto somente após a seleção do cliente ou projeto.

Ao concluir uma ação, o sistema:

1. salva a entrega no projeto correto;
2. atualiza o status da entrega e do projeto;
3. registra um evento resumido no histórico;
4. atualiza o painel quando houver mudança acionável;
5. oferece salvar aprendizados permanentes apenas quando necessário.

## 9. Sistema de skills

### Elementos diferentes

- **Skill:** fluxo de trabalho orientado ao usuário.
- **Capacidade:** motor técnico, como HyperFrames, navegador ou renderizador.
- **Conector:** integração autenticada, como Meta, Google Ads ou WhatsApp.
- **Playbook:** combinação de skills para alcançar um resultado maior.

Essa separação impede que uma documentação de negócio seja misturada com instalação técnica e credenciais.

### Skills essenciais instaladas

1. `onboarding` — configura modo, negócio, preferências e identidade.
2. `central-de-trabalho` — painel, prioridades e retomada de sessão.
3. `clientes-e-projetos` — cria, abre, lista, conclui e arquiva.
4. `conteudo-e-carrosseis` — pauta, roteiro, carrossel, legenda e reaproveitamento.
5. `sites-e-landing-pages` — briefing, copy, design, implementação e verificação.
6. `propostas-e-ofertas` — oferta, escopo, proposta e materiais comerciais.
7. `analise-de-arquivos` — documentos, planilhas e resumo executivo.
8. `criador-de-skills` — transforma processos repetíveis em novas skills validadas.

### Capacidades e packs opcionais

- Estúdio de Vídeo.
- Meta Ads.
- Google Ads.
- SEO.
- WhatsApp e atendimento.
- CRM e acompanhamento comercial.
- Relatórios e indicadores.
- Publicação em redes sociais.
- Pesquisa na internet.
- Documentos, apresentações e planilhas avançadas.

## 10. Contrato obrigatório de uma skill

Cada skill é um pequeno produto e deve conter:

```text
<skill-id>/
├── SKILL.md
├── references/
├── scripts/
├── assets/
├── examples/
├── tests/
└── LICENSE.txt
```

Somente `SKILL.md` é obrigatório para skills simples. Os demais diretórios existem quando a skill realmente precisa deles.

O `SKILL.md` deve declarar:

- nome, descrição e gatilhos;
- problema resolvido e entregas possíveis;
- quando usar e quando não usar;
- entradas obrigatórias e opcionais;
- dependências e permissões;
- instalação ou conexão guiada;
- fluxo de orientação, preparação, execução, verificação e aprendizado;
- critérios objetivos de qualidade;
- prévia e aprovações necessárias;
- regras de salvamento;
- falhas esperadas e recuperação;
- exemplos mínimos;
- política de dados e credenciais;
- versão e compatibilidade.

Referências longas ficam fora do `SKILL.md` e são carregadas sob demanda. Scripts são executados sem serem despejados no contexto. Esse desenho segue a prática atual de skills com progressive disclosure usada pelo Claude Code e pelo ecossistema de skills do Codex.

## 11. Criação e detecção de novas skills

### Criação guiada

O `criador-de-skills` coleta objetivo, gatilho, entradas, etapas, saída, critérios de qualidade e dependências. Antes de instalar, ele produz uma prévia, valida a estrutura e executa um caso de teste aprovado pelo usuário.

### Detecção de repetição

Cada tarefa concluída gera um evento local resumido com categoria, tipo de entrada, tipo de saída, cliente/projeto e data. O conteúdo integral da entrega não é copiado para o histórico.

Uma sugestão de automação ocorre quando:

- uma atividade semanticamente equivalente aparece pelo menos três vezes em 30 dias;
- não existe skill instalada que já cubra a atividade;
- o usuário não recusou a mesma sugestão nos últimos 30 dias.

O sistema oferece criar uma skill, criar somente um modelo ou ignorar. Nunca cria ou instala automaticamente.

## 12. Economia de tokens

O modo econômico é uma característica do núcleo e não depende de ferramentas externas.

Regras da V1:

- instruções raiz curtas e estáveis;
- uma skill carregada por vez, salvo fluxo composto explícito;
- referências abertas somente quando necessárias;
- índices resumidos para clientes e projetos;
- resumo persistente por sessão e projeto;
- histórico detalhado fora do contexto padrão;
- nenhuma leitura global de todos os artefatos;
- respostas nos níveis `curta`, `normal` e `detalhada`.

O RTK pode ser oferecido como otimização opcional para tarefas com terminal. Ponytail pode ser ativado somente em trabalho técnico. Caveman não integra a instalação padrão, pois sua comunicação comprimida conflita com a clareza exigida pelo público.

## 13. Estúdio de Vídeo

O usuário vê uma única skill chamada `estudio-de-video`. Um roteador interno seleciona a capacidade:

- **Criar do zero, motion graphics e vídeos promocionais:** HyperFrames.
- **Editar gravações, entrevistas e talking heads:** Video Use.
- **Projeto React existente ou composição especializada:** Remotion, quando solicitado.

### Instalação

O Estúdio de Vídeo não vem instalado na base. Ao primeiro uso, o sistema explica tamanho, dependências, licenças e possíveis custos antes de instalar.

- HyperFrames: Node.js 22+, FFmpeg, licença Apache 2.0.
- Video Use: Python 3.10+, FFmpeg e chave da ElevenLabs para a transcrição padrão, licença MIT.
- Remotion: dependências React e condições de licença verificadas na versão escolhida antes da ativação comercial.

### Fluxo

```text
briefing ou mídia bruta
        ↓
estratégia e roteiro
        ↓
aprovação do plano
        ↓
produção ou edição
        ↓
prévia de baixa resolução
        ↓
verificação técnica e visual
        ↓
aprovação final
        ↓
render e salvamento no projeto
```

## 14. Anúncios e conectores

Os packs Meta Ads e Google Ads evoluem em três níveis:

1. **Preparar:** estratégia, estrutura, criativos e arquivo de importação.
2. **Ler:** conexão autenticada e análise de campanhas e resultados.
3. **Executar:** criação de campanhas pausadas, prévia e publicação após aprovação.

Credenciais ficam em armazenamento local ignorado pelo Git e nunca entram em memória, briefing, histórico ou entrega. A documentação de conexão aponta para a versão atual da API e registra a data de verificação.

Toda ação que possa gastar dinheiro exige confirmação explícita de conta, orçamento, período, campanha e status. O padrão de criação é pausado.

## 15. Portabilidade entre agentes

As skills canônicas ficam em `skills/`. Adaptadores mínimos expõem descrição e gatilhos no formato exigido pelo host, apontando para a mesma fonte canônica.

- `CLAUDE.md` e adaptadores em `.claude/skills/` atendem Claude Code.
- `AGENTS.md` e o instalador de skills atendem Codex.
- Nenhuma regra de negócio é duplicada nos adaptadores.

O instalador detecta o host, mostra o que será configurado e valida a descoberta de uma skill simples. Falhas em um adaptador não corrompem os dados do workspace.

## 16. Segurança e tratamento de erros

- Nunca misturar contexto entre clientes.
- Nunca sobrescrever entrega aprovada, publicada ou entregue.
- Nunca guardar segredo em arquivo versionado.
- Nunca publicar, enviar mensagem, modificar campanha ou gastar sem aprovação.
- Mostrar uma prévia do plano antes de tarefas longas ou com custo externo.
- Registrar falha, causa provável e próximo passo no projeto.
- Se uma dependência faltar, interromper somente a capacidade afetada.
- Se uma integração estiver indisponível, preservar o trabalho como rascunho exportável.
- Validar caminhos para impedir gravação no cliente ou projeto incorreto.
- Conservar arquivos-fonte originais em tarefas de mídia e análise.

## 17. Testes e qualidade

### Validação estrutural

- frontmatter obrigatório e valores permitidos;
- IDs únicos e caminhos consistentes;
- referências existentes;
- ausência de credenciais e placeholders;
- licenças declaradas para recursos de terceiros.

### Testes de skills

- gatilho correto;
- caso mínimo de sucesso;
- entrada ausente;
- dependência indisponível;
- salvamento no cliente e projeto corretos;
- tentativa de sobrescrever entrega aprovada;
- aprovação obrigatória para ações externas.

### Cenário de aceitação da fundação

1. Configurar o produto no modo Prestador/Agência.
2. Criar dois clientes.
3. Criar dois projetos para o primeiro cliente e um para o segundo.
4. Gerar uma entrega em cada projeto.
5. Aprovar uma entrega e solicitar uma alteração.
6. Confirmar que uma nova versão foi criada.
7. Abrir o painel e ver projetos e pendências corretos.
8. Confirmar que nenhum dado de um cliente aparece no outro.
9. Repetir uma atividade três vezes e receber a sugestão de nova skill.
10. Reiniciar a sessão e continuar pelo resumo persistido.

## 18. Fases de implementação

### Fundação V1

Estrutura da pasta, onboarding, manifests, clientes, projetos, entregas, painel, contexto seletivo, histórico e validadores.

### Skills essenciais

Contrato de skill, oito skills instaladas, catálogo, criador de skills e detector de repetição.

### Packs opcionais

Estúdio de Vídeo, anúncios, WhatsApp, SEO e outras capacidades instaláveis, cada uma entregue e testada separadamente.

### Aplicativo

Interface visual que lê e altera os mesmos manifests, índices e artefatos da versão em pasta.

## 19. Critérios de conclusão da V1

A V1 estará pronta quando:

- uma pessoa nova conseguir configurar o workspace seguindo apenas `COMECE-AQUI.md`;
- os dois modos de operação funcionarem;
- clientes, projetos e entregas permanecerem isolados e navegáveis;
- o painel indicar corretamente a próxima ação;
- as oito skills essenciais passarem seus cenários mínimos;
- uma nova skill puder ser criada, validada e instalada;
- repetições gerarem sugestões sem criar automações automaticamente;
- Claude Code e Codex descobrirem e executarem uma skill de teste;
- o sistema funcionar sem instalar os packs opcionais;
- nenhuma ação externa sensível ocorrer sem aprovação.

## 20. Referências técnicas verificadas

- Claude Code Skills: <https://code.claude.com/docs/en/skills>
- OpenAI Skills: <https://github.com/openai/skills>
- HyperFrames: <https://github.com/heygen-com/hyperframes>
- Video Use: <https://github.com/browser-use/video-use>
- Remotion: <https://www.remotion.dev/docs>
- RTK: <https://github.com/rtk-ai/rtk>
- Ponytail: <https://github.com/DietrichGebert/ponytail>
- Meta Marketing API: <https://developers.facebook.com/docs/marketing-apis/>
- Google Ads API: <https://developers.google.com/google-ads/api/docs/start>

