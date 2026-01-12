return {
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    init = function()
      vim.opt.laststatus = 3 -- Uses a single global statusline (cleaner look)
      vim.opt.splitkeep = 'screen'
    end,
    opts = {
      bottom = {
        -- Trouble (Diagnostics/LSP)
        {
          ft = 'trouble',
          title = 'Trouble',
        },
        -- Terminal 1
        {
          ft = 'toggleterm',
          title = 'Terminal',
          -- Filter to ensure we only grab standard terminals, not floating ones
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ''
          end,
          size = { height = 0.3 }, -- Take up 30% of the screen height
        },
        -- Quickfix list
        { ft = 'qf', title = 'QuickFix' },
      },
      left = {
        -- Neo-tree (File Explorer)
        {
          ft = 'neo-tree',
          title = 'Neo-Tree',
          pinned = true,
          open = 'Neotree show left',
        },
      },
    },
  },
}
