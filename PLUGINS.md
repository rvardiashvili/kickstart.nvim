# Neovim Plugin Guide

This document explains the purpose of each plugin in your custom configuration and how to use it.

## 🎨 Theme & UI

### `catppuccin/nvim`
*   **What it does**: Provides the "Mocha" color scheme (dark, pastel, high contrast).
*   **How to use**: It loads automatically. You can toggle between flavors (Latte, Frappe, Macchiato, Mocha) using `:colorscheme catppuccin-<flavor>`.

### `akinsho/bufferline.nvim`
*   **What it does**: Displays open buffers (files) as tabs at the top of the window.
*   **How to use**:
    *   Click on a tab to switch to it.
    *   Use `<leader><leader>` (Telescope buffers) to search and jump to open buffers.
    *   Run `:bdelete` (or `:bd`) to close the current buffer.

### `nvim-lualine/lualine.nvim`
*   **What it does**: The status line at the bottom of the window showing mode (NORMAL/INSERT), file path, branch, and diagnostics.
*   **How to use**: Purely informational. It updates automatically.

### `nvim-neo-tree/neo-tree.nvim`
*   **What it does**: A file explorer sidebar.
*   **How to use**:
    *   **Toggle**: Press `<leader>e`.
    *   **Navigate**: `j`/`k` to move, `Enter` to open, `a` to add a file, `d` to delete, `r` to rename.
    *   **Help**: Press `?` inside the window to see all commands.

### `folke/which-key.nvim`
*   **What it does**: Shows a popup with available keybindings when you pause mid-sequence.
*   **How to use**: Press `<leader>` (Space) and wait a second. A menu will appear showing what keys you can press next (e.g., `s` for Search, `g` for Git).

### `folke/edgy.nvim`
*   **What it does**: Manages window layouts, keeping sidebars (like Neo-tree, Trouble, Terminal) pinned to the edges.
*   **How to use**: Automatic. It organizes windows so they don't overlap awkwardly.

---

## 🚀 Navigation & Editing

### `lewis6991/gitsigns.nvim`
*   **What it does**: Shows git changes (+, ~, -) in the left gutter.
*   **How to use**:
    *   **Preview Hunk**: `<leader>hp` (if configured, or check `:help gitsigns`).
    *   **Next Hunk**: `]c`
    *   **Previous Hunk**: `[c`

### `folke/todo-comments.nvim`
*   **What it does**: Highlights `TODO`, `FIXME`, `HACK`, etc., in comments.
*   **How to use**: Just write `// TODO: fix this` and it will highlight. Run `:TodoTelescope` to find all todos.

### `folke/trouble.nvim`
*   **What it does**: A pretty list for showing diagnostics (errors/warnings) and LSP references.
*   **How to use**:
    *   **Toggle Diagnostics**: `<leader>xx`.
    *   **Toggle Buffer Diagnostics**: `<leader>xX`.
    *   **LSP References**: `<leader>cl` (if configured in debugging.lua).
    *   **Navigate**: `j`/`k` to select, `Enter` to jump.

### `ThePrimeagen/harpoon`
*   **What it does**: Fast file switching for a small set of "hot" files you are currently working on.
*   **How to use**:
    *   **Add file**: `<leader>a` adds the current file to the list.
    *   **Menu**: `<C-e>` opens the list to edit/reorder.
    *   **Jump**: `<leader>1` through `<leader>4` jumps instantly to those files.

### `folke/flash.nvim`
*   **What it does**: Lets you jump anywhere on screen with 2-3 keystrokes.
*   **How to use**:
    *   Press `s`.
    *   Type two characters found in the target location (e.g., "fu" for "function").
    *   Flash will highlight matches with labels (like `A`, `B`, `C`). Press that label key to jump there.

### `nvim-telescope/telescope.nvim`
*   **What it does**: Fuzzy finder for everything (files, text, help, etc.).
*   **How to use**:
    *   `<leader>sf`: Search Files (by name).
    *   `<leader>sg`: Search Grep (search text *inside* files).
    *   `<leader>sh`: Search Help.
    *   `<leader>sk`: Search Keymaps.
    *   `<leader><leader>`: Search Open Buffers.

### `windwp/nvim-autopairs`
*   **What it does**: Automatically adds closing brackets `)` `]` `}` and quotes.
*   **How to use**: Just type `(` and it will insert `()`.

### `windwp/nvim-ts-autotag`
*   **What it does**: Automatically closes HTML/XML tags.
*   **How to use**: Type `<div>` and it will automatically insert `</div>`.

### `numToStr/Comment.nvim`
*   **What it does**: Toggles comments on code.
*   **How to use**:
    *   `gcc`: Comment/uncomment current line.
    *   `gc` + motion (e.g., `gcip` for paragraph): Comment text object.
    *   `gc` in Visual Mode: Comment selection.

### `Wansmer/treesj`
*   **What it does**: Smartly splits or joins blocks of code (like dicts, structs, argument lists) using Treesitter.
*   **How to use**:
    *   **Toggle**: `<leader>m` (Splits if joined, Joins if split).
    *   **Split**: `<leader>s` (Expand to multi-line).
    *   **Join**: `<leader>j` (Collapse to single-line).

---

## 💾 Session & Git

### `kdheepak/lazygit.nvim`
*   **What it does**: Opens the `lazygit` terminal UI inside Neovim.
*   **How to use**: Press `<leader>gg`. Use the terminal UI to stage, commit, push, etc. Press `q` to close.

### `folke/persistence.nvim`
*   **What it does**: Automatically saves the state of your open windows and buffers.
*   **How to use**:
    *   **Restore**: `<leader>qs` (Restores session for current directory).
    *   **Restore Last**: `<leader>ql` (Restores the very last session you had).
    *   **Stop Saving**: `<leader>qd` (Don't save the session for this instance).

---

## 🧠 Languages & LSP

### `neovim/nvim-lspconfig`
*   **What it does**: Connects Neovim to Language Servers (LSP) for error checking, Go to Definition, etc.
*   **How to use**:
    *   **Go to Definition**: `grd`
    *   **Go to References**: `grr`
    *   **Rename Variable**: `grn`
    *   **Code Action**: `gra` (Fix imports, extract function, etc.)
    *   **Hover Doc**: `K` (Shift+k)

### `linux-cultist/venv-selector.nvim` (Python)
*   **What it does**: Lets you select which Python Virtual Environment (`venv` or `conda`) to use.
*   **How to use**:
    *   Open a Python file.
    *   Press `<leader>v`.
    *   Select your environment from the list.

### `saghen/blink.cmp`
*   **What it does**: The autocompletion popup menu.
*   **How to use**:
    *   Start typing code.
    *   Use `Ctrl+n` / `Ctrl+p` (or Up/Down) to select suggestion.
    *   Use `Ctrl+y` (Yes) to accept.

### `mfussenegger/nvim-lint` & `stevearc/conform.nvim`
*   **What they do**:
    *   **Lint**: Shows warnings (via `markdownlint`, `ruff`, `eslint_d`).
    *   **Conform**: Auto-formats code.
*   **How to use**:
    *   **Format Manually**: `<leader>f`.
    *   **Auto-format**: Configured to run on save for most files.

---

## 🐛 Debugging

### `mfussenegger/nvim-dap`
*   **What it does**: Debug Adapter Protocol client (like VS Code debugger).
*   **How to use**:
    *   **Toggle Breakpoint**: `<leader>b`.
    *   **Start Debugging**: `<F5>`.
    *   **Step Over**: `<F2>`.
    *   **Step Into**: `<F1>`.

### `rcarriga/nvim-dap-ui`
*   **What it does**: Opens a UI with Variables, Stack Frames, and Console when debugging starts.
*   **How to use**: Opens automatically when you press `<F5>`.

---

## 🖥️ Terminal

### `akinsho/toggleterm.nvim`
*   **What it does**: Manages integrated terminals.
*   **How to use**:
    *   **Floating Terminal**: `<leader>tt` or `<C-\>`.
    *   **Specific Terminals**: `<leader>t1`, `<leader>t2`...
    *   **Exit Insert Mode**: `Esc` then `Esc` (double escape) to go to Normal mode inside terminal to copy text.
