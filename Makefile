.POSIX:
.SILENT:

MAKEFLAGS += --no-print-directory -s

# ----------------------------------------------------------------
# Makefile: Vim Classic Editor
# ----------------------------------------------------------------

.PHONY: help test headless ci

### ================================
### HELP & DOCUMENTATION
### ================================
help:
	cmd() { printf "    \033[36mmake %-22s\033[0m %s\n" "$$1" "$$2"; }; \
	sec() { printf "\n  \033[1;33m%s\033[0m\n" "$$1"; }; \
	printf "\n  \033[1;37mVim — Configuração Clássica Resiliente UNIX & Vimscript\033[0m\n"; \
	printf "  ============================================================\n"; \
	sec "Qualidade & Validação:"; \
	cmd "test"           "Valida inicialização em modo silencioso/headless"; \
	cmd "headless"       "Executa boot limpo headless do Vim"; \
	cmd "ci"             "Executa suíte de validação local do Vim"; \
	echo ""


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

ci: test
	echo "🚀 Vim 100% pronto para produção!"
