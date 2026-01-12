# Neovim Plugin Handbook 📚

This document serves as a comprehensive guide to all plugins installed in this configuration, their purpose, and their usage instructions.

---

## 🤖 AI & Coding Assistance

### 1. GitHub Copilot (`copilot.vim`)
*   **Purpose**: Provides AI-powered ghost-text completions as you type.
*   **Usage**:
    *   `Alt + l`: Accept the current suggestion.
    *   `Alt + \`: Manually trigger a suggestion.
    *   `Alt + ]`: Cycle to the next suggestion.
    *   `Alt + [`: Cycle to the previous suggestion.
    *   `Alt + Backspace`: Dismiss the current suggestion.
    *   `:CopilotToggle`: Enable or disable Copilot globally.

### 2. Copilot Chat (`CopilotChat.nvim`)
*   **Purpose**: A full chat interface for interacting with GitHub Copilot inside Neovim.
*   **Usage**:
    *   `<leader>ac`: Open/Close the chat sidebar.
    *   `<leader>at`: Toggle the chat window.
    *   `<leader>aq`: Quick Chat (opens an input prompt for a single question).
    *   **Visual Mode Actions**:
        *   `<leader>ae`: **Explain** the selected code.
        *   `<leader>af`: **Fix** the selected code (proposes a solution).
        *   `<leader>ar`: **Review** the selected code for improvements.
        *   `<leader>ap`: **Optimize** the selected code.

### 3. AIRA Integration (Custom Local Agent)
*   **Purpose**: A high-performance local AI assistant bridge. It has project-wide awareness and can autonomously execute tools.
*   **Usage**:
    *   `:AiraChat`: Opens the persistent AIRA sidebar.
    *   **Inside Chat Window**:
        *   Type after the `**User**:` line.
        *   `Enter` (Normal Mode): Send your message to AIRA.
        *   `<leader>cc`: Clear chat history.
    *   **Commands & Maps**:
        *   `<leader>aa`: Ask AIRA (standard prompt).
        *   `<leader>ap`: Ask AIRA with **Project Mode** (includes file tree and config files in context).
        *   `<leader>ax`: **Smart Fix** (Fixes the LSP diagnostic/error under the cursor).
        *   `<leader>ae` (Visual): Explain the current selection.
        *   `<leader>ar` (Visual): Refactor the current selection.
        *   `:AiraToggleProject`: Toggle project-wide context for all queries.
        *   `:AiraNewSession`: Reset the conversation history.

---

## 🚀 Navigation & Motion

### 1. Harpoon 2 (`harpoon`)
*   **Purpose**: Rapidly switch between a small set of "hot" files.
*   **Usage**:
    *   `<leader>a`: Add the current file to your Harpoon list.
    *   `Ctrl + e`: Toggle the Harpoon quick-menu (edit the list).
    *   `<leader>1`, `<leader>2`, `<leader>3`, `<leader>4`: Jump instantly to file 1, 2, 3, or 4.

### 2. Flash (`flash.nvim`)
*   **Purpose**: Jump anywhere on the screen with 2-3 characters.
*   **Usage**:
    *   `s`: Search and Jump mode. Type two letters, then the label that appears.
    *   `S`: Treesitter Jump mode (selects nodes based on labels).

### 3. Telescope (`telescope.nvim`)
*   **Purpose**: The primary fuzzy finder for files, text, and diagnostics.
*   **Usage**:
    *   `<leader>sf`: Search Files by name.
    *   `<leader>sg`: Live Grep (search text inside files).
    *   `<leader>sw`: Search current Word under cursor.
    *   `<leader>sd`: Search Diagnostics (errors/warnings).
    *   `<leader><leader>`: Search open buffers.
    *   `<leader>sn`: Search Neovim configuration files.

---

## 🖥️ UI & Layout

### 1. Neo-tree (`neo-tree.nvim`)
*   **Purpose**: A modern file explorer sidebar.
*   **Usage**:
    *   `<leader>e`: Toggle the file tree.
    *   Inside tree: `a` (Add), `d` (Delete), `r` (Rename), `?` (Help).

### 2. Bufferline (`bufferline.nvim`)
*   **Purpose**: Displays open files as fancy tabs at the top.
*   **Usage**: Click on tabs or use `:bnext`/`:bprev`.

### 3. Edgy (`edgy.nvim`)
*   **Purpose**: Manages sidebars (Neo-tree, Chat, Terminal) to keep them fixed to window edges.

### 4. Which-Key (`which-key.nvim`)
*   **Purpose**: Shows a popup guide when you start a key sequence (e.g., press `<leader>` and wait).

---

## 🧠 Languages & LSP

### 1. LSP Config (`nvim-lspconfig`)
*   **Purpose**: Connects to language servers for real-time error checking.
*   **Optimized Python**: Suppresses NoneType noise and dynamic library errors (GTK/PyQt).
*   **Keymaps**:
    *   `grd`: Go to Definition.
    *   `grr`: Go to References.
    *   `grn`: Rename symbol.
    *   `gra`: Code Actions (Fixes).
    *   `K`: Show documentation (Hover).

### 2. Blink.cmp (`blink.cmp`)
*   **Purpose**: Lightning-fast completion engine.
*   **Usage**: `Ctrl + n`/`p` to select, `Ctrl + y` to accept.

### 3. Conform & Lint
*   **Purpose**: Automatic code formatting and linting.
*   **Usage**: Code is formatted on save. Use `<leader>f` to format manually.

### 4. Venv Selector (`venv-selector.nvim`)
*   **Purpose**: Switch between Python virtual environments.
*   **Usage**: `<leader>v` inside a Python file.

---

## 💾 System & Git

### 1. LazyGit (`lazygit.nvim`)
*   **Purpose**: Full terminal UI for Git.
*   **Usage**: `<leader>gg` to open. Press `q` to exit.

### 2. ToggleTerm (`toggleterm.nvim`)
*   **Purpose**: Manages persistent terminals.
*   **Usage**:
    *   `Ctrl + \`: Toggle the default horizontal terminal.
    *   `<leader>tt`: Toggle terminal.
    *   `<leader>t1`, `<leader>t2`, `<leader>t3`: Toggle specific numbered terminals.

### 3. Persistence (`persistence.nvim`)
*   **Purpose**: Automatically saves and restores your session (open files/windows).
*   **Usage**:
    *   `<leader>qs`: Restore session for current directory.
    *   `<leader>ql`: Restore the absolute last session.

---

## 🐛 Debugging

### 1. DAP & DAP-UI (`nvim-dap`)
*   **Purpose**: Step-through debugger (VSCode-like).
*   **Usage**:
    *   `<F5>`: Start or Continue debugging.
    *   `<F1>`: Step Into.
    *   `<F2>`: Step Over.
    *   `<F3>`: Step Out.
    *   `<leader>b`: Toggle Breakpoint.
