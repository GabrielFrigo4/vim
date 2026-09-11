# 📜 Vim Configuration (vimfiles) — AI Agent Briefing

> Este é o repositório da **configuração clássica do Vim** (`vimfiles`) de Gabriel Frigo, integrante da **Suíte de Editores** do ecossistema [Universal Environment](https://github.com/GabrielFrigo4/environment).

---

## 🧭 Identidade e Papel

O repositório `vimfiles` provê uma configuração de alta compatibilidade e robustez para o Vim clássico, com runtimepath dinâmico, detecção segura de Vim-Plug, destaque de sintaxe multilíngue e tema CodeDark com fallback.

---

## 📁 Estrutura Canônica de Arquivos

- **`vimrc`**: Arquivo de configuração principal com opções gerais, runtimepath dinâmico, plugins (Vim-Plug) e mapeamentos.
- **`autoload/plug.vim`**: Gerenciador de plugins Vim-Plug embutido para zero-friction bootstrap.
- **`README.md`**: Guia institucional e instruções de symlink.
- **`AGENTS.md`**: Briefing para agentes de IA.
- **`PRINCIPLES.md`**: Os 18 Princípios de Engenharia UNIX + Clean Code sincronizados.
- **`ENVIRONMENT.md`**: Manifesto do ecossistema sincronizado.

---

## ⚠️ Invariantes Críticas para Agentes de IA

1. **Fail-Safe Startup:** O `vimrc` NUNCA deve quebrar ou lançar mensagens de erro se os plugins ainda não tiverem sido instalados ou se `codedark` estiver ausente. `silent! colorscheme` e `if exists('*plug#begin')` são obrigatórios.
2. **Onipresença UNIX:** A configuração deve funcionar perfeitamente em servidores remotos, terminais sem suporte gráfico e máquinas virtuais limpas.
3. **Zero Comentários Narrativos:** Mantenha a arquitetura de comentários em 3 camadas (`"` e réguas de 64/32 caracteres).
4. **Zero Secrets:** Nunca armazenar credenciais ou tokens neste repositório.

---

## 📖 Referências Obrigatórias

- **[ENVIRONMENT.md](ENVIRONMENT.md)**: Arquitetura global do ecossistema
- **[PRINCIPLES.md](PRINCIPLES.md)**: Os 18 Princípios de Engenharia UNIX + Clean Code
- **[.agents/rules/principles.md](.agents/rules/principles.md)**: Regras específicas para o Vim
- **[.agents/skills/](.agents/skills/)**: Runbooks operacionais do Vim
