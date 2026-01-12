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
### General
*   `<Space>`: Leader Key

### Navigation (Harpoon)
*   `<leader>a`: Add file to Harpoon
*   `<C-e>`: Toggle Harpoon menu
*   `<leader>1-4`: Navigate to Harpoon file 1-4

### File Explorer (Neo-tree)
*   `<leader>e`: Toggle File Explorer

### Terminal (ToggleTerm)
*   `<C-\>`: Toggle Terminal (Floating/Docked)
*   `<leader>tt`: Toggle Default Terminal
*   `<leader>t1/t2/t3`: Toggle specific terminal instances

### Debugging (DAP)
*   `<F5>`: Start/Continue
*   `<F1>`: Step Into
*   `<F2>`: Step Over
*   `<F3>`: Step Out
*   `<leader>b`: Toggle Breakpoint

### Git (LazyGit)
*   `<leader>gg`: Open LazyGit

### Session Management
*   `<leader>qs`: Restore Session
*   `<leader>ql`: Restore Last Session

### Code Manipulation (TreesJ)
*   `<leader>m`: Toggle Split/Join
*   `<leader>j`: Join Block
*   `<leader>s`: Split Block

## ⚡ Performance Notes

Most plugins are configured with `event`, `ft`, or `keys` triggers.
*   **LSP/Treesitter**: Loads on `BufReadPre` (when you actually open a file).
*   **Completion (Blink)**: Loads on `InsertEnter`.
*   **Debugger**: Loads only when you press a debug key (e.g., `<F5>`).

This ensures Neovim starts up almost instantly and only consumes RAM for the tools you are currently using.   

## Install
```sh
git clone https://github.com/rvardiashvili/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```
