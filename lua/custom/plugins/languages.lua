return {
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    ft = 'python',
    opts = {},
    keys = {
      { '<leader>v', '<cmd>VenvSelect<cr>' },
    },
  },
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    ft = 'rust',
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Define which linters to run for which filetypes
      lint.linters_by_ft = {
        -- markdown = { 'markdownlint' },
        -- python = { 'pylint' }, -- Disabled in favor of Ruff LSP
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        -- json = { 'jsonlint' },
      }

      -- Create an autocommand to trigger linting
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
