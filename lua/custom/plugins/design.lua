return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        integrations = {
          cmp = true,
          gitsigns = true,
          neotree = true,
          telescope = true,
          notify = true, -- Used by Noice
          mini = {
            enabled = true,
          },
          treesitter = true,
          mason = true,
          which_key = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
