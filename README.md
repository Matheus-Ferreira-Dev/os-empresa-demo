# OS Empresa — Demo V1

Um sistema operacional de trabalho para pequenos negócios, prestadores de serviço e infoprodutores. Ele organiza clientes, projetos e entregáveis em uma pasta simples e usa skills para orientar o trabalho.

Esta é uma prévia funcional para avaliação. Não é o produto completo e não inclui publicação automática, integrações de anúncios ou pacotes de vídeo.

## Instalação rápida

### Windows (recomendado)

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\instalar.ps1 -Target .\meu-negocio
Set-Location .\meu-negocio
```

### macOS/Linux

```bash
chmod +x ./instalar.sh
./instalar.sh ./meu-negocio
cd meu-negocio
```

Depois, abra `COMECE-AQUI.md` e peça ao seu agente de código para seguir as instruções de `AGENTS.md` ou `CLAUDE.md`.

## O que testar

- cadastrar um cliente e mais de um projeto;
- criar um carrossel com roteiro, legenda e CTA;
- criar uma landing page local com briefing, copy e `index.html`;
- pedir uma nova skill e revisar a proposta antes de instalá-la;
- consultar `painel.md` para saber o estado de cada projeto.
- gerar `sistema/contexto-minimo.md` para trabalhar com menos tokens.

## Segurança da prévia

Os arquivos são locais, não exigem chaves de API e não publicam nada na internet. Conteúdo opcional de HyperFrames, Video Use, Remotion, RTK, Ponytail e Caveman está documentado em `sistema/catalogo.md`, mas não vem instalado.

## Menos tokens

Depois de criar ou alterar projetos, rode `powershell -File scripts/gerar-indice.ps1` e `powershell -File scripts/compactar-contexto.ps1`. O agente deve ler o resumo, um manifesto e uma skill por vez, sem carregar entregas completas.

## Licença

Consulte `LICENSE.txt` e `NOTICE-THIRD-PARTY.md`. Este material é uma demonstração privada para avaliação.
