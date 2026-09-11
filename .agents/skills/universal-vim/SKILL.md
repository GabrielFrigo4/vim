---
name: universal-vim
description: >-
    Operational runbook for maintaining, testing, and debugging Gabriel Frigo's Vim configuration.
    Use when editing vimrc, installing/updating Vim-Plug plugins, tweaking mappings, or verifying headless startup.
---

# Universal Vim — Operational Runbook

Este guia detalha o fluxo operacional para gerenciar, auditar e testar a configuração do Vim.

---

## 1. Teste de Inicialização em Modo Headless

Sempre valide o boot do Vim sem erros:

```sh
vim -u vimrc -es -c "quit"
```

O comando deve encerrar com código de saída 0 sem warnings ou erros obstrutivos.

---

## 2. Gerenciamento de Plugins via Vim-Plug

Dentro do Vim:

- `:PlugInstall`: Baixa e instala plugins configurados.
- `:PlugUpdate`: Atualiza plugins para as versões mais recentes.
- `:PlugClean`: Remove plugins desativados.
- `:PlugStatus`: Verifica integridade dos plugins instalados.

---

## 3. Sincronização de Dotfiles

Para vincular esta configuração ao diretório oficial do Vim:

```sh
# Via Profile do Universal Environment
make sync

# Ou criação manual de links
ln -sf "$(pwd)/vimrc" "${HOME}/.vimrc"
ln -sf "$(pwd)" "${HOME}/vimfiles"
ln -sf "$(pwd)" "${HOME}/.vim"
```
