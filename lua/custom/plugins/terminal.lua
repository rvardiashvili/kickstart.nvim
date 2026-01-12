return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('toggleterm').setup {
        size = 20,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'horizontal',
        close_on_exit = true,
      }

      -- Window navigation (Removed Ctrl+j to use for toggling the panel)
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
      vim.api.nvim_set_keymap('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
      vim.api.nvim_set_keymap('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)

      local Terminal = require('toggleterm.terminal').Terminal

      -- Define your terminals
      local term_1 = Terminal:new { count = 1, display_name = 'Terminal 1' }
      local term_2 = Terminal:new { count = 2, display_name = 'Terminal 2' }
      local term_3 = Terminal:new { count = 3, display_name = 'Terminal 3' }

      -- Toggle individual tabs
      vim.keymap.set('n', '<leader>t1', function()
        term_1:toggle()
      end, { desc = 'Toggle Terminal 1' })
      vim.keymap.set('n', '<leader>t2', function()
        term_2:toggle()
      end, { desc = 'Toggle Terminal 2' })
      vim.keymap.set('n', '<leader>t3', function()
        term_3:toggle()
      end, { desc = 'Toggle Terminal 3' })

      -- Helper: Toggle both T1 and T2 so you can see the tab bar immediately
      vim.keymap.set('n', '<leader>ta', function()
        term_1:open()
        term_2:open()
      end, { desc = 'Open Terminal 1 & 2 (Show Tabs)' })

      vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<cr>', { desc = 'Toggle Default Terminal' })
    end,
  },
}
