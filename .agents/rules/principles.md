# 📜 Vim Engineering Principles & Guidelines

> Regras de engenharia e diretrizes de desenvolvimento para a configuração do Vim.

---

## 🏛️ Invariantes de Vimscript

1. **Portabilidade Máxima:** Configurações devem funcionar em qualquer versão moderna do Vim (8.0+) em Linux, FreeBSD, macOS e Windows.
2. **Defensividade contra Falha de Plugins:** Comandos e atalhos atrelados a plugins (`NERDTreeToggle`, `Files`, `Rg`) devem degradar silenciosamente caso o plugin não esteja carregado.
3. **Arquitetura de Comentários em 3 Camadas:**
    - Topo: Header Banner com 64 `-` (`" --------------------------------...`).
    - Seções: Delimitador com 32 `=` (`" ================================`).
    - Subseções: Delimitador com 32 `-` (`" --------------------------------`).
    - Sem comentários de ruído inline.
4. **Respeito à Soberania do Usuário:** Não sobrescrever atalhos padrão essenciais do Vim sem justificativa ergonômica explícita.
