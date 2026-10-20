---
name: universal-vim
description: Runbook operacional para desenvolvimento, auditoria, testes headless e manutenção de plugins Vim-Plug no editor clássico Vim. Use ao modificar vimrc, auditar atalhos, testar inicialização em servidores remotos ou executar rotinas de validação.
---

# 📜 Universal Vim — Runbook Operacional

Este runbook orienta desenvolvedores e agentes de inteligência artificial na manutenção, auditoria e sincronização da configuração do editor clássico **Vim (8.2+ / 9.x)**.

---

## 🏛️ Diretrizes & Baseline Arquitetural

1. **Onipresença UNIX & Alta Resiliência:** Configuração compatível com estações modernas, contêineres e servidores headless bare-metal (Linux, FreeBSD, macOS, illumos).
2. **Fail-Safe Startup:**
    - Detecção dinâmica de `runtimepath` e gerenciador Vim-Plug embutido (`autoload/plug.vim`).
    - Inicialização silenciosa e graciosa mesmo quando executado em máquinas sem conexão à internet ou com plugins ainda não instalados.
3. **Isolamento de Estado:**
    - `vimrc`: Configuração declarativa única de opções, mapeamentos e lista de plugins.
    - `autoload/plug.vim`: Gerenciador autônomo versionado no próprio repositório.
4. **Zero Symlinks Frágeis:** O repositório opera clonado como árvore canônica em `${HOME}/.vim` (com `${HOME}/.vimrc` apontando canonicamente para `${HOME}/.vim/vimrc`) ou `%USERPROFILE%\vimfiles` no Windows.
5. **Ergonomia de Cursor Adaptativa (PTY vs Linux TTY):**
    - **Em PTY Gráfico:** Utiliza sequências DECSCUSR piscantes canônicas em paridade com o NeoVim (`t_SI = \e[5 q`, `t_SR = \e[3 q`, `t_EI = \e[1 q`, `t_te = \e[0 q`) com grupo `PTYCursor` no `ModeChanged` para modo Visual (`\e[1 q`) e Linha de Comando (`\e[5 q`, alinhado ao Helix).
    - **Em Linux Console TTY (`$TERM == 'linux'`):** Alavanca os 5 formatos nativos de hardware do kernel Linux VT via escape sequences privativas CSI `\e[?<N>c`:
        - Modo Inserção (`*:i*`): `\e[?2c` (Underline na base)
        - Modo Linha de Comando (`*:c*`, `CmdlineEnter`): `\e[?3c` (Lower Third - 1/3 inferior)
        - Modo Substituição e Operator-Pending (`*:r*`, `*:R*`, `*:o*`): `\e[?4c` (Lower Half - metade inferior)
        - Modo Visual (`*:v*`, `*:V*`, `*:\<C-V\>*`, `*:s*`, `*:S*`, `*:\<C-S\>*`): `\e[?5c` (Two Thirds - 2/3 inferiores, com `s:ApplyRawTTYHighlights()` aplicando `highlight Visual cterm=NONE ctermfg=15 ctermbg=4` e paleta estrita de 16 cores `0..15` compatível com `t_Co=16`)
        - Modo Normal (`*:n*`, `CmdlineLeave`): `\e[?6c` (Full Block - bloco sólido)
        - **Sanitização de Redraw (`t_ve` / `t_vi`):** Por padrão, o terminfo `linux` associa `cnorm` (`t_ve`) a `\e[?25h\e[?0c` e `civis` (`t_vi`) a `\e[?25l\e[?1c`. O reset embutido `\e[?0c` clobberava os formatos customizados em cada refresh de tela. O Vim força `t_ve=\e[?25h`, `t_vi=\e[?25l` e `t_VS=\e[?25h`, garantindo integridade visual dos modos.
        - **Responsividade de Escape (`ttimeoutlen=50`):** Define `set ttimeout` e `set ttimeoutlen=50` eliminando o delay de 1000ms na transição entre Inserção e Normal ao pressionar `<Esc>`.
        - Encerramento / Suspensão (`VimLeave, VimSuspend`): Emite a sequência canônica de auto-cura `\e%G\e[?16;238;0c`, restaurando o softcursor branco estático sem pisque e imune a distorções cromáticas.

---

## 🧪 1. Validação em Modo Headless

Sempre teste a inicialização limpa do Vim antes de efetuar commits ou concluir alterações:

```sh
# Via Makefile canônico
make test

# Ou via script unificado de componente
./vim.sh test

# Ou diretamente via comando vim headless/silencioso
vim -u vimrc -es -c "quit"
```

> [!IMPORTANT]
> O comando DEVE retornar código de saída `0` sem exibir warnings, mensagens de funções desconhecidas ou travar a sessão em espera de input do usuário.

---

## 🔍 2. Diagnóstico do Ambiente (`doctor`)

Para inspecionar o runtime e a versão do binário:

```sh
./vim.sh doctor
```

Dentro de uma sessão interativa do Vim:

```vim
:version
```

---

## 📦 3. Gerenciamento de Plugins via Vim-Plug

Em sessões interativas do Vim:

- **Instalar Plugins:** `:PlugInstall`
- **Atualizar Plugins:** `:PlugUpdate`
- **Limpar Plugins Inativos:** `:PlugClean`
- **Verificar Integridade:** `:PlugStatus`

---

## 🚀 4. Sincronização & Deploy Soberano

O repositório opera de forma independente ou gerenciado pelo **Universal Environment**:

```sh
# A partir do Universal Environment (orquestrador pai)
make uped    # Atualiza a suite de editores com upstream
make deploy  # Sincroniza clones nos destinos canonicos

# Ou clonagem direta e vinculação canônica
git clone "https://github.com/GabrielFrigo4/vim.git" "${HOME}/.vim"
ln -sf "${HOME}/.vim/vimrc" "${HOME}/.vimrc"
```

---

## 🔗 Links Oficiais de Referência

- [Vim Official Website](https://www.vim.org/)
- [Vim Online Documentation](https://vimhelp.org/)
- [Vim-Plug Repository](https://github.com/junegunn/vim-plug)
- [Vimscript Language Documentation](https://vimhelp.org/usr_41.txt.html)
