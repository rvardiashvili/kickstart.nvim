return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        size = 20, -- height of horizontal terminal
        open_mapping = [[<C-\>]], -- your toggle key
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true, -- allows <C-\> in insert mode
        persist_size = true,
        direction = 'horizontal', -- can be "vertical", "horizontal", "tab", "float"
        close_on_exit = true,
      }
      -- Optional: Navigate between terminal and normal windows with Ctrl+h/j/k/l
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
      vim.api.nvim_set_keymap('t', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
      vim.api.nvim_set_keymap('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
      vim.api.nvim_set_keymap('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
    end,
  },
}
