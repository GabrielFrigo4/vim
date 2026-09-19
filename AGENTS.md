# 📜 Vim Configuration (vimfiles) — AI Agent Briefing

> Este é o repositório da **configuração clássica do Vim** (`vimfiles`) de Gabriel Frigo, integrante da **Suíte de Editores** do ecossistema [Universal Environment](https://github.com/GabrielFrigo4/environment).

---

## 🧭 Identidade e Papel

O repositório `vimfiles` provê uma configuração de alta compatibilidade e robustez para o Vim clássico, com runtimepath dinâmico, detecção segura de Vim-Plug, destaque de sintaxe multilíngue e tema CodeDark com fallback.

---

## 📁 Estrutura Canônica de Arquivos

- **`vimrc`**: Arquivo de configuração principal com opções gerais, runtimepath dinâmico, plugins (Vim-Plug) e mapeamentos.
- **`autoload/plug.vim`**: Gerenciador de plugins Vim-Plug embutido para zero-friction bootstrap.
- **`README.md`**: Guia institucional e instruções de symlink.
- **`AGENTS.md`**: Briefing para agentes de IA.
- **`PRINCIPLES.md`**: Os 18 Princípios de Engenharia UNIX + Clean Code sincronizados.
- **`ENVIRONMENT.md`**: Manifesto do ecossistema sincronizado.

---

## ⚠️ Invariantes Críticas para Agentes de IA

1. **Fail-Safe Startup:** O `vimrc` NUNCA deve quebrar ou lançar mensagens de erro se os plugins ainda não tiverem sido instalados ou se `codedark` estiver ausente. `silent! colorscheme` e `if exists('*plug#begin')` são obrigatórios.
2. **Onipresença UNIX:** A configuração deve funcionar perfeitamente em servidores remotos, terminais sem suporte gráfico e máquinas virtuais limpas.
3. **Zero Comentários Narrativos:** Mantenha a arquitetura de comentários em 3 camadas (`"` e réguas de 64/32 caracteres).
4. **Zero Secrets:** Nunca armazenar credenciais ou tokens neste repositório.
5. **Hermetismo de Produção & Invariante `rm -rf .agents`:** Repositório 100% autônomo. Zero acoplamento de configurações a `.agents/` ou `skills/` (o Vim opera plenamente se `.agents/` for deletado).
6. **Bancada de Desenvolvimento vs. Runtimes de Produção:** Em produção, o Vim reside e opera soberanamente em `~/.vim` (ou `~/vimfiles`). O repositório central `Environment` é exclusivamente uma bancada de desenvolvimento. NUNCA aponte symlinks no SO para `~/Documents/Environment/Editor/Vim`.
7. **Invariante de Clonagem "Out-of-the-Box" (Zero-Tweaks Git Invariant):** O Vim deve funcionar imediatamente após `git clone`. Modos octais no Git Index DEVEM ser rigorosamente `0755` para `vim.sh` e hooks, e `0644` para `vimrc`, plugins embutidos e documentação.
8. **Governança de Roadmap (Opção C):** O repositório mantém seu [TODO.md](TODO.md) atualizado com a Matriz de Status e Backlog de Evolução, sincronizado com o badge no `README.md`.

---

## 🛡️ Regra da Proatividade e Correção Contínua (Boy Scout Rule)

O agente de IA **DEVE SER ATIVAMENTE PROATIVO** na manutenção e aplicação dos padrões canônicos deste repositório.

Se durante a execução de qualquer tarefa (seja criação de novas features, correções pontuais, refatorações ou investigação) o agente identificar qualquer linha de código, script, Makefile ou documentação fora dos padrões estabelecidos, **NÃO DEVE HESITAR NEM IGNORAR**:

1. **Notificar concisamente** o usuário sobre a divergência encontrada.
2. **Corrigir imediatamente a inconformidade**, aplicando o padrão canônico correspondente:
    - **Comentários Narrativos:** Eliminar imediatamente comentários óbvios que apenas narram código executável.
    - **Banners Estruturais:** Ajustar réguas para exatamente 64 hífens no topo ou 32 caracteres com `### ` no corpo.
    - **Portabilidade POSIX:** Substituir bashismos (`[[ ]]`, `&>`, arrays, `source`) por sintaxe estrita POSIX `/bin/sh`.
    - **Shebang Universal:** Garantir sempre `#!/usr/bin/env sh` ou `#!/usr/bin/env python3`.
    - **Sequências ANSI:** Substituir octais crípticos (`\033`) e `printf` desnecessário por `[ -t 1 ] && echo -n $'\e...'`.
    - **Redirecionamento Seguro:** Envolver destinos em aspas duplas (ex: `> "/dev/null" 2>&1`).
    - **Makefiles:** Assegurar cabeçalho `.POSIX: .SILENT:`, `MAKEFLAGS += --no-print-directory -s`, alinhamento estético de variáveis e zero `@` redundante.
    - **Permissões Canônicas:** Aplicar 4 dígitos octais (`chmod 0755`, `chmod 0644`, `chmod 0700`, `chmod 0600`).
    - **Invariante Out-of-the-Box:** Garantir modos octais corretos no Git Index sem requerer intervenção manual pós-clone.
    - **Curadoria Cognitiva:** Capturar decisões estruturais e regras tácitas em skills locais compactas (`.agents/skills/`), mantendo-as atualizadas e expurgando runbooks obsoletos para evitar débito cognitivo, preservando sempre o hermetismo de produção (`rm -rf .agents`).

## 📖 Referências Obrigatórias

Antes de qualquer modificação neste ecossistema, consulte:

- **[ENVIRONMENT.md](ENVIRONMENT.md)**: Arquitetura global do ecossistema
- **[PRINCIPLES.md](PRINCIPLES.md)**: Os 21 Princípios de Engenharia UNIX + Clean Code
- **[TODO.md](TODO.md)**: Planejamento estratégico e matriz de status operacional
- **[.agents/rules/principles.md](.agents/rules/principles.md)**: Regras específicas para o Vim
- **[.agents/skills/](.agents/skills/)**: Runbooks operacionais do Vim
