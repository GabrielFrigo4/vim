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
