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

---

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
    - **Sequências ANSI:** Substituir octais crípticos (``) e `printf` desnecessário por `[ -t 1 ] && echo -n $'\e...'`.
    - **Redirecionamento Seguro:** Envolver destinos em aspas duplas (ex: `> "/dev/null" 2>&1`).
    - **Makefiles:** Assegurar cabeçalho `.POSIX: .SILENT:`, `MAKEFLAGS += --no-print-directory -s`, alinhamento estético de variáveis e zero `@` redundante.
    - **Permissões Canônicas:** Aplicar 4 dígitos octais (`chmod 0755`, `chmod 0644`, `chmod 0700`, `chmod 0600`).

## 📖 Referências Obrigatórias

- **[ENVIRONMENT.md](ENVIRONMENT.md)**: Arquitetura global do ecossistema
- **[PRINCIPLES.md](PRINCIPLES.md)**: Os 18 Princípios de Engenharia UNIX + Clean Code
- **[.agents/rules/principles.md](.agents/rules/principles.md)**: Regras específicas para o Vim
- **[.agents/skills/](.agents/skills/)**: Runbooks operacionais do Vim
