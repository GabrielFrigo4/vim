# 🗺️ Roadmap & Status — Classic UNIX Vim

> **Status:** 🟢 **100% Operacional & Estável — Zero Pendências Ativas**
> Rastreamento relativo, tema CodeDark, FZF recursivo, comentários nativos e fallback TTY foram integralmente concluídos.

---

## 📊 Matriz de Maturidade

| Área                         |   Status    | Cobertura / Estado                                                                       |
| :--------------------------- | :---------: | :--------------------------------------------------------------------------------------- |
| **Resiliência TTY & Mouse**  | 🟢 Estável  | Detecção de `$RAW_TTY`, console Linux/FreeBSD, fallback `default` e mouse `gpm`/`moused` |
| **Mouse SGR no Console**     | 🟢 Estável  | Protocolo SGR 1006 via `&t_TI`/`&t_TE` no FreeBSD `vt(4)` e Linux raw TTY                |
| **Cursor Colorido por Modo** | 🟢 Estável  | Sequências OSC 12 e highlights no TTY FreeBSD sem alteração física de forma              |
| **Terminal Embutido**        | 🟢 Estável  | Paleta `g:terminal_ansi_colors` de 16 cores e navegação ágil com `Esc`/`C-\ C-n`         |
| **Comentários Nativos**      | 🟢 Estável  | Toggler leve (`gcc`/`gc`) sem dependências de plugins externos                           |
| **Vim-Plug & FZF**           | 🟢 Estável  | Bootstrapping estrito e busca difusa rápida via `fzf.vim`                                |
| **Paridade Multiplataforma** | 🟢 Estável  | Suporte verificado em Linux, FreeBSD, macOS e Windows (`vimfiles`)                       |
| **Conformidade de Banners**  | 🟢 Estável  | Réguas padronizadas de 32 colunas e ausência de comentários óbvios                       |
| **Quality Gates**            | 🟢 Aprovado | Boot headless validado via `make test`                                                   |

---

## 🛡️ Atributos Entregues

- **Zero Pendências:** Editor clássico UNIX robusto, sem complexidade acidental e 100% autônomo.
- **Mouse SGR & Fallback TTY:** Ativação de sequências SGR 1006 no console FreeBSD (`vt4`) e Linux raw TTY via `&t_TI` / `&t_TE`.
- **Cursor em Bloco Colorido por Modo no TTY:** Implementação estética via sequências OSC 12 e highlights de cursor no TTY do FreeBSD sem suporte a `DECSCUSR`.
- **Terminal Embutido & Paleta ANSI 16 Cores:** Configuração de `g:terminal_ansi_colors` sincronizada com o terminal e mapeamentos ergonômicos no modo terminal.
- **Sincronização:** Total alinhamento com os 22 Princípios de Engenharia UNIX do Universal Environment.

---

## 📌 Backlog & Próximos Passos

---

> [!TIP]
> Para detalhes sobre a arquitetura e convenções de engenharia, consulte o [PRINCIPLES.md](PRINCIPLES.md) e o [ENVIRONMENT.md](ENVIRONMENT.md).
