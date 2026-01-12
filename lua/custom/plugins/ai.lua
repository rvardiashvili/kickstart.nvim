return {
  {
    'github/copilot.vim',
    config = function()
      -- Disable default tab mapping
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true

      -- Keybindings
      -- Accept suggestion with <M-l> (Alt+l)
      vim.keymap.set('i', '<M-l>', [[copilot#Accept("\<CR>")]], {
        expr = true,
        replace_keycodes = false,
      })

      -- Next/Prev suggestions
      vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)')
      vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)')
      vim.keymap.set('i', '<M-BS>', '<Plug>(copilot-dismiss)')
      
      -- Suggestion toggle
      vim.keymap.set('i', [[<M-\>]], [[copilot#Suggest()]], {
        expr = true,
        replace_keycodes = false,
      })

      -- Global toggle
      vim.api.nvim_create_user_command('CopilotToggle', function()
        if vim.g.copilot_enabled == 1 then
          vim.cmd('Copilot disable')
          print("Copilot disabled")
        else
          vim.cmd('Copilot enable')
          print("Copilot enabled")
        end
      end, {})      
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken', -- Only on MacOS/Linux
    opts = {
      debug = false,
      show_help = true,
      question_header = '## User ',
      answer_header = '## Copilot ',
      error_header = '## Error ',
      prompts = {
        Explain = 'Please explain how the following code works.',
        Review = 'Please review the following code and provide suggestions for improvement.',
        Fix = 'Please fix the following code to make it work as intended.',
        Optimize = 'Please optimize the following code to improve performance and readability.',
        Docs = 'Please add documentation comments to the following code.',
        Tests = 'Please generate unit tests for the following code.',
        FixDiagnostic = 'Please fix the following LSP diagnostic error.',
      },
    },
    keys = {
      { '<leader>ac', '<cmd>CopilotChatOpen<cr>', desc = 'CopilotChat - Open' },
      { '<leader>at', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
      { '<leader>ae', '<cmd>CopilotChatExplain<cr>', mode = 'v', desc = 'CopilotChat - Explain' },
      { '<leader>af', '<cmd>CopilotChatFix<cr>', mode = 'v', desc = 'CopilotChat - Fix' },
      { '<leader>ar', '<cmd>CopilotChatReview<cr>', mode = 'v', desc = 'CopilotChat - Review' },
      { '<leader>ap', '<cmd>CopilotChatOptimize<cr>', mode = 'v', desc = 'CopilotChat - Optimize' },
      -- Quick chat with input
      {
        '<leader>aq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        desc = 'CopilotChat - Quick Chat',
      },
    },
  },
}