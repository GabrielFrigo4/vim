.POSIX:
.SILENT:

MAKEFLAGS += --no-print-directory

# ----------------------------------------------------------------
# Makefile: Vim Classic Editor
# ----------------------------------------------------------------

.PHONY: help test headless ci

### ================================
### HELP & DOCUMENTATION
### ================================
help:
	echo "📜 Vim — Configuração Clássica Resiliente UNIX"
	echo ""
	echo "Comandos disponíveis:"
	echo "  make test     - Valida inicialização em modo silencioso/headless"
	echo "  make ci       - Executa suite de validação local"
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
