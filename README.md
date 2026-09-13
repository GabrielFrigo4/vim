# 📜 Universal Vim Configuration

> Configuração clássica, resiliente e de alta portabilidade do editor Vim com Vim-Plug e tema CodeDark.

[![Environment](https://img.shields.io/badge/🏛️_Environment-Hub-blue)](https://github.com/GabrielFrigo4/environment)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Vimscript](https://img.shields.io/badge/script-Vimscript-blue)](vimrc)

---

## 🧭 Visão Geral

Este repositório contém a configuração oficial do **Vim** de Gabriel Frigo, integrando a **Suíte de Editores** do [Universal Environment](https://github.com/GabrielFrigo4/environment). Projetado com foco em:

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

### Opção A — Modo Versionado (Recomendado para Manutenção)

Clona o repositório diretamente no destino canônico com controle de versão Git ativo, permitindo atualizações automáticas contínuas via `uped` ou `git pull`.

#### 🐧 Unix (Linux, FreeBSD, macOS)

```sh
git clone "https://github.com/GabrielFrigo4/vim.git" "${HOME}/.vim"
ln -sf "${HOME}/.vim/vimrc" "${HOME}/.vimrc"
```

#### 🪟 Windows (PowerShell Nativo)

```powershell
git clone "https://github.com/GabrielFrigo4/vim.git" "$HOME\vimfiles"
```

#### 🪟 Windows (MSYS2 / Git Bash)

```sh
git clone "https://github.com/GabrielFrigo4/vim.git" "${HOME}/.vim"
ln -sf "${HOME}/.vim/vimrc" "${HOME}/.vimrc"
```

---

### Opção B — Modo Standalone Limpo (Zero-Bloat / Produção)

> [!TIP]
> **Filosofia Zero-Bloat:** Ideal para servidores, contêineres ou computadores de terceiros onde o controle de versão Git e artefatos de desenvolvimento não são necessários. Clona a árvore rasa (`--depth=1`) e remove metadados (`.git*`, `.agents`, `*.md`), deixando apenas a configuração estritamente executável.

#### 🐧 Unix (Linux, FreeBSD, macOS & MSYS2)

```sh
git clone --depth=1 "https://github.com/GabrielFrigo4/vim.git" "${HOME}/.vim" && \
  ln -sf "${HOME}/.vim/vimrc" "${HOME}/.vimrc" && \
  rm -rf "${HOME}/.vim/.git"* "${HOME}/.vim/.agents" "${HOME}/.vim/"*.md
```

#### 🪟 Windows (PowerShell)

```powershell
git clone --depth=1 "https://github.com/GabrielFrigo4/vim.git" "$HOME\vimfiles"
Remove-Item -Recurse -Force "$HOME\vimfiles\.git*", "$HOME\vimfiles\.agents", "$HOME\vimfiles\*.md" -ErrorAction SilentlyContinue
```

---

### ⚙️ Integração com o Universal Environment

Quando operado a partir do [Universal Environment](https://github.com/GabrielFrigo4/environment):

```sh
# Atualizar a suíte de editores com o upstream
make uped

# Implantar o repositório no destino canônico (~/vimfiles e ~/.vimrc)
make deploy
```

---

### 🔌 Instalar Plugins e Validação

Abra o Vim e execute:

```vim
:PlugInstall
```

Ou valide em modo headless via CLI:

```sh
vim -u vimrc -es -c "quit"
```
