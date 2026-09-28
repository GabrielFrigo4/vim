#!/usr/bin/env sh
# ----------------------------------------------------------------
# Interface: Vim Classic Editor Component
# ----------------------------------------------------------------
set -eu

_VIM_ROOT="$(cd "$(dirname "$0")" && pwd)"

_self_heal_perms() {
	if [ -d "${_VIM_ROOT}/.git" ] && command -v git > "/dev/null" 2>&1; then
		git -C "${_VIM_ROOT}" config core.hooksPath .githooks 2> "/dev/null" || true
	fi
	if [ -d "${_VIM_ROOT}/.githooks" ]; then
		chmod 0755 "${_VIM_ROOT}/.githooks/"* 2> "/dev/null" || true
	fi
	[ -f "${_VIM_ROOT}/vim.sh" ] && chmod 0755 "${_VIM_ROOT}/vim.sh" 2> "/dev/null" || true
}
_self_heal_perms

_vim_help() {
	cat <<- EOF
		Vim — Interface Unificada de Componente

		Uso:
		  vim.sh [comando]

		Comandos:
		  test      Valida inicializacao limpa do Vim em modo headless
		  doctor    Verifica presenca do binario vim e ambiente
		  help      Exibe esta mensagem de ajuda
	EOF
}

_vim_test() {
	echo "🧪 [Vim] Validando inicialização headless..."
	if command -v vim > "/dev/null" 2>&1; then
		vim -u "${_VIM_ROOT}/vimrc" -es -c "quit" > "/dev/null" 2>&1 && echo "  ✅ Vim: headless OK"
	else
		echo "ℹ️  vim não encontrado no PATH; ignorando teste headless."
	fi
}

_vim_doctor() {
	echo "🔍 [Vim] Diagnóstico do componente..."
	if command -v vim > "/dev/null" 2>&1; then
		echo "  ✅ vim detectado: $(command -v vim)"
		vim --version | head -n 1 | sed 's/^/     /'
	else
		echo "  ❌ vim não encontrado no PATH."
	fi
}

_cmd="${1:-help}"
case "${_cmd}" in
	test|headless) _vim_test ;;
	doctor)        _vim_doctor ;;
	help|-h|--help) _vim_help ;;
	*)
		echo "❌ Comando desconhecido: ${_cmd}" >&2
		_vim_help >&2
		exit 1
		;;
esac
