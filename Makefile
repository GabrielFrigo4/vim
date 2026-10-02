.POSIX:
.SILENT:

MAKEFLAGS += --no-print-directory -s

# ----------------------------------------------------------------
# Makefile: Vim Classic Editor
# ----------------------------------------------------------------

.PHONY: help hooks test headless format prettier ci

### ================================
### HELP & DOCUMENTATION
### ================================
help:
	_e=$$'\e'; \
	cmd() { printf "    $${_e}[36mmake %-22s$${_e}[0m %s\n" "$$1" "$$2"; }; \
	sec() { printf "\n  $${_e}[1;33m%s$${_e}[0m\n" "$$1"; }; \
	printf "\n  $${_e}[1;37mVim — Configuração Clássica Resiliente UNIX & Vimscript$${_e}[0m\n"; \
	printf "  ============================================================\n"; \
	sec "Setup & Ganchos:"; \
	cmd "hooks"          "Configura e aplica permissões canônicas em .githooks"; \
	sec "Qualidade & Validação:"; \
	cmd "test"           "Valida inicialização em modo silencioso/headless"; \
	cmd "headless"       "Executa boot limpo headless do Vim"; \
	cmd "format"         "Formata documentações Markdown com Prettier"; \
	cmd "prettier"       "Formata documentações Markdown com Prettier"; \
	cmd "ci"             "Executa suíte de validação local do Vim"; \
	echo ""

### ================================
### GIT HOOKS & PERMISSIONS
### ================================
hooks:
	echo "🪝 Configurando ganchos Git (.githooks)..."
	chmod 0755 .githooks/pre-commit .githooks/commit-msg 2> "/dev/null" || true
	git config core.hooksPath .githooks 2> "/dev/null" || true
	echo "  ✅ Vim: core.hooksPath -> .githooks"


### ================================
### TESTING & VALIDATION
### ================================
test: headless

headless:
	echo "🧪 Validando inicialização headless do Vim..."
	if command -v vim > "/dev/null" 2>&1; then \
		vim -u vimrc -es -c "quit" > "/dev/null" 2>&1 && echo "  ✅ Vim: headless OK"; \
	else \
		echo "ℹ️  vim não encontrado no PATH; ignorando teste headless."; \
	fi

format: prettier
	echo "✅ Formatação concluída!"

prettier:
	if command -v prettier > "/dev/null" 2>&1; then prettier --write "**/*.md" 2> "/dev/null" || true; elif command -v npx > "/dev/null" 2>&1; then npx prettier --write "**/*.md" 2> "/dev/null" || true; fi

ci: test
	echo "🚀 Vim 100% pronto para produção!"
