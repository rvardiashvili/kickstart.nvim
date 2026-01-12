return {
  {
    'linux-cultist/venv-selector.nvim',
  },
  {
    'mfussenegger/nvim-jdtls',
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Define which linters to run for which filetypes
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        python = { 'pylint' },
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
  {
    'stevearc/conform.nvim',
  },
}
