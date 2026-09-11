# 📜 Vim Configuration (vimfiles)

> Configuração clássica, resiliente e de alta portabilidade do editor Vim com Vim-Plug e tema CodeDark.

[![Environment](https://img.shields.io/badge/🏛️_Environment-Hub-blue)](https://github.com/GabrielFrigo4/environment)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Vimscript](https://img.shields.io/badge/script-Vimscript-blue)](vimrc)

---

## 🧭 Visão Geral

Este repositório contém a configuração oficial do **Vim** (`vimfiles`) de Gabriel Frigo, integrando a **Suíte de Editores** do [Universal Environment](https://github.com/GabrielFrigo4/environment). Projetado com foco em:

- **Onipresença UNIX:** Funciona em qualquer terminal, servidor headless ou estação de trabalho gráfica.
- **Fail-Safe Startup:** Detecção dinâmica de `runtimepath` e inicialização limpa sem warnings caso plugins externos ainda não estejam instalados.
- **Ecossistema Vim-Plug:** Plugins de navegação rápida (FZF, NERDTree, Surround, Visual-Multi).
- **Tema CodeDark:** Visual escuro estilo VS Code com fallback gracioso para o tema padrão.

---

## 📁 Catálogo da Estrutura

| Arquivo / Diretório                      | Descrição                                                     |
| :--------------------------------------- | :------------------------------------------------------------ |
| [`vimrc`](vimrc)                         | Configuração principal do Vim com opções, plugins e atalhos   |
| [`autoload/plug.vim`](autoload/plug.vim) | Gerenciador de plugins Vim-Plug embutido                      |
| [`AGENTS.md`](AGENTS.md)                 | Briefing arquitetural para agentes de inteligência artificial |
| [`PRINCIPLES.md`](PRINCIPLES.md)         | Os 18 Princípios de Engenharia UNIX + Clean Code              |
| [`ENVIRONMENT.md`](ENVIRONMENT.md)       | Manifesto do ecossistema Universal Environment                |

---

## 🚀 Instalação e Uso Rápido

### 1. Vincular via Profile

```sh
# Sincronização automática via Universal Environment
make sync

# Ou criação manual de links
ln -sf "$(pwd)/vimrc" "${HOME}/.vimrc"
ln -sf "$(pwd)" "${HOME}/vimfiles"
ln -sf "$(pwd)" "${HOME}/.vim"
```

### 2. Instalar Plugins

Abra o Vim e execute:

```vim
:PlugInstall
```

### 3. Validação Headless

```sh
vim -u vimrc -es -c "quit"
```
