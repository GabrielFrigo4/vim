# 🤝 Guia de Contribuição — Vim Classic Editor

> Diretrizes de desenvolvimento, arquitetura clássica Vimscript, Vim-Plug e quality gates para a configuração de **Vim**.

---

## 🚀 Setup Inicial da Bancada (Primeiros Passos)

Para clonar e configurar o repositório localmente com todos os ganchos e quality gates ativados:

```sh
# 1. Clonar o repositório
git clone "https://github.com/GabrielFrigo4/vim.git" "${HOME}/Documents/Vim"
cd "${HOME}/Documents/Vim"

# 2. Configurar ganchos Git e permissões canônicas
make hooks

# 3. Validar inicialização silenciosa/headless
make test

# 4. Executar a suíte de validação local
make ci
```

> [!IMPORTANT]
> O comando `make hooks` configura `core.hooksPath -> .githooks` e aplica permissões canônicas `0755` aos ganchos de pre-commit e commit-msg. Execute-o sempre após um novo clone.

---

## 🛡️ Invariantes de Engenharia no Vim

1. **Configuração Clássica em Vimscript:**
    - `vimrc`: Configuração central, modularizada em blocos lógicos.
    - `autoload/`: Funções de carregamento sob demanda e bootstrap automático do gerenciador `vim-plug`.

2. **Invariante de Clonagem "Out-of-the-Box" (Zero-Tweaks Invariant):**
    - Scripts executáveis (`vim.sh`) devem possuir modo octal `100755` no Git Index.
    - Arquivos Vimscript (`vimrc`, `autoload/*.vim`), documentações e licença devem possuir modo `100644`.
    - Se cometer um erro de modo no Git Index, corrija com:
        ```sh
        git update-index --chmod=+x vim.sh
        git update-index --chmod=-x vimrc
        ```

3. **Hermetismo Headless:**
    - A configuração deve inicializar e finalizar sem travar em modo ex/batch:
        ```sh
        vim -u vimrc -es -c "quit"
        ```

---

## 🪝 Quality Gates & Validação Local

O repositório possui validações automatizadas:

```sh
make test      # Testa inicialização silenciosa/headless
make ci        # Executa bateria de qualidade completa
```

Ganchos Git em `.githooks/`:

- **`pre-commit`:** Verifica whitespace, modos octais no Git Index (0755 vs 0644), sintaxe Vimscript/shell e formatação.
- **`commit-msg`:** Valida formato semântico da mensagem de commit.

---

## 📝 Convenção de Commits Semânticos

As mensagens de commit devem seguir o formato:

```text
<tipo>(<escopo>): <descrição objetiva>
```

Tipos permitidos: `feat`, `fix`, `refactor`, `docs`, `style`, `test`, `ci`, `chore`.

---

## 📖 Referências Canônicas

- [README.md](README.md) — Visão geral da configuração do Vim
- [PRINCIPLES.md](PRINCIPLES.md) — Princípios de Engenharia e Clean Code
- [AGENTS.md](AGENTS.md) — Briefing para agentes autônomos de IA
- [TODO.md](TODO.md) — Roadmap operacional do Vim
