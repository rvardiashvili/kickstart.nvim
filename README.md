# Custom Neovim Configuration

This is a personalized Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). It has been refactored into a modular structure with a heavy focus on performance (lazy-loading) and specific language support for Python, Java, and Rust.

## 🚀 Key Features

*   **Modular Architecture**: Plugins are organized by category in `lua/custom/plugins/`.
*   **Performance Optimized**: Heavy plugins (LSP, Treesitter, Debuggers) are lazy-loaded on file open, insert enter, or command usage.
*   **Language Support**:
    *   **Python**: `Pyright` (Type Checking) + `Ruff` (Linting/Formatting) + `venv-selector`.
    *   **Java**: `nvim-jdtls`.
    *   **Rust**: `rustaceanvim`.
*   **Modern UI**: `catppuccin` theme, `neo-tree` file explorer, `bufferline`, and `lualine`.
*   **Navigation**: `Harpoon` (ThePrimeagen style) and `Flash.nvim` for rapid movement.

## 📂 Project Structure

```text
/home/rati/.config/nvim/
├── init.lua                # Core setup: Options, Keymaps, LSP/Treesitter bootstrap
├── lua/
│   └── custom/
│       └── plugins/
│           ├── design.lua      # Theme (Catppuccin), Noice
│           ├── ui.lua          # Visuals: Neo-tree, Lualine, Bufferline
│           ├── nav.lua         # Movement: Harpoon, Flash
│           ├── languages.lua   # Lang-specific: Python (venv), Java, Rust, Linting
│           ├── debugging.lua   # DAP (Debug Adapter Protocol) setup
│           ├── editor.lua      # Editing aids: Autopairs, Comments
│           ├── terminal.lua    # ToggleTerm configuration
│           └── layout.lua      # Edgy.nvim (window layout management)
```

## 🛠️ Language Server Setup

### Python
*   **LSP**: `Pyright` is configured strictly for **Type Checking**.
*   **Linter/Formatter**: `Ruff` handles linting (unused imports, style violations) and formatting.
    *   *Note*: Pyright's `reportUnusedImport` and `reportUnusedVariable` are disabled to avoid conflicts with Ruff.
*   **Virtual Envs**: `venv-selector` (loads on opening `.py` files) lets you pick your python environment via `<leader>v`.

### Java & Rust
*   **Java**: Uses `nvim-jdtls` (loads on opening `.java` files).
*   **Rust**: Uses `rustaceanvim` (loads on opening `.rs` files).

## ⌨️ Custom Keymaps

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
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```
