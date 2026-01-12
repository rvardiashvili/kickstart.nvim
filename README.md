# Custom Neovim Configuration

A high-performance, modular Neovim setup based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), tuned for Senior Software Engineering workflows.

## 🚀 Key Features

*   **⚡ Blazing Fast**: Lazy-loaded modular architecture using `lazy.nvim`.
*   **🤖 Dual-AI Layer**:
    *   **GitHub Copilot**: Real-time inline suggestions.
    *   **Copilot Chat**: Conversational AI for code review and refactoring.
    *   **AIRA Integration**: Local, autonomous agent with project-wide search and edit capabilities.
*   **🐍 Pro Python Support**:
    *   Optimized `Pyright` to silence "NoneType" and dynamic library noise (GTK, PyQt).
    *   `Ruff` configured for critical errors only.
    *   `venv-selector` for seamless environment switching.
*   **🛠️ Full Toolkit**: Integrated Debugger (DAP), terminal management, and fast navigation (Harpoon/Flash).

## 📂 Project Structure

```text
/home/rati/.config/nvim/
├── init.lua                # Core settings & LSP bootstrap
├── PLUGINS.md              # Detailed Plugin Handbook & Usage Guide
├── lua/
│   ├── aira.lua            # Local AI Agent bridge
│   └── custom/
│       └── plugins/        # Categorized plugin configurations
```

## 📥 Quick Setup

1.  **Dependencies**: Install `git`, `gcc`, `ripgrep`, `fd`, and `lazygit`.
2.  **Copilot**: Run `:Copilot setup` after launch.
3.  **AIRA**: Ensure `~/AIRA` is installed for local agent features.

## ⌨️ Essential Keymaps

| Key | Action |
| :--- | :--- |
| `<Space>` | **Leader Key** |
| `<leader>e` | Toggle File Explorer (Neo-tree) |
| `<leader>sf` | Search Files (Telescope) |
| `s` | Jump to anything (Flash) |
| `Alt + l` | Accept AI Completion (Copilot) |
| `<leader>ac` | Toggle Copilot Chat |
| `:AiraChat` | Open Local Agent Sidebar |
| `<leader>gg` | Open LazyGit |
| `<F5>` | Start Debugger |

---
*Refer to [PLUGINS.md](./PLUGINS.md) for the full handbook.*