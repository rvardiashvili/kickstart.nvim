local M = {}

-- Configuration
local config = {
  python_bin = os.getenv("HOME") .. "/AIRA/venv/bin/python",
  script = os.getenv("HOME") .. "/AIRA/scripts/aira_headless.py",
  project_mode = false,
  sidebar_width = 40,
  session_id = "nvim_" .. tostring(os.time()) .. "_" .. tostring(math.random(1000, 9999))
}

-- State
local chat_buf = nil
local chat_win = nil
local job_id = nil

-- --- UTILITIES ---

local function get_visual_selection()
  local _, srow, scol = unpack(vim.fn.getpos('v'))
  local _, erow, ecol = unpack(vim.fn.getpos('.'))
  
  if vim.fn.mode() == 'V' then
    srow, erow = math.min(srow, erow), math.max(srow, erow)
    local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
    return table.concat(lines, "\n")
  else
    if srow > erow then srow, erow = erow, srow end
    if scol > ecol then scol, ecol = ecol, scol end
    local lines = vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
    return table.concat(lines, "\n")
  end
end

local function get_current_diagnostic()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if #diagnostics > 0 then
    return diagnostics[1].message
  end
  return nil
end

local function setup_chat_syntax()
  vim.cmd([[
    syntax match AiraUser /^\*\*User\*\*:/
    syntax match AiraBot /^\*\*AIRA\*\*:/
    syntax match AiraTool /^> Executing tool:/
    highlight link AiraUser WarningMsg
    highlight link AiraBot Directory
    highlight link AiraTool Comment
  ]])
end

function M.send_from_chat()
  local lines = vim.api.nvim_buf_get_lines(chat_buf, 0, -1, false)
  local last_user_idx = -1
  for i = #lines, 1, -1 do
    if lines[i]:match("^%*%*User%*%*:") then
      last_user_idx = i
      break
    end
  end

  local prompt = ""
  if last_user_idx ~= -1 then
    local content_lines = {}
    for i = last_user_idx, #lines do
      local l = lines[i]:gsub("^%*%*User%*%*:%s*", "")
      table.insert(content_lines, l)
    end
    prompt = table.concat(content_lines, "\n"):gsub("^%s*(.-)%s*$", "%1")
  end

  if prompt ~= "" then
    M.query(prompt, { skip_user_label = true })
  else
    print("AIRA: No prompt found. Type after '**User**:'")
  end
end

local function ensure_chat_window()
  if chat_win and vim.api.nvim_win_is_valid(chat_win) then
    vim.api.nvim_set_current_win(chat_win)
    return
  end
  
  -- Create split
  vim.cmd('vsplit')
  chat_win = vim.api.nvim_get_current_win()
  vim.cmd('vertical resize ' .. config.sidebar_width)
  
  -- Create or reuse buffer
  if not chat_buf or not vim.api.nvim_buf_is_valid(chat_buf) then
    chat_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(chat_buf, 'filetype', 'markdown')
    vim.api.nvim_buf_set_option(chat_buf, 'bufhidden', 'hide')
    vim.api.nvim_buf_set_option(chat_buf, 'swapfile', false)
    
    -- Keymaps for the chat buffer
    vim.keymap.set('n', '<CR>', M.send_from_chat, { buffer = chat_buf, desc = 'Send to AIRA' })
    vim.keymap.set('n', '<leader>cc', function()
      vim.api.nvim_buf_set_lines(chat_buf, 0, -1, false, {"**User**: "})
      local count = vim.api.nvim_buf_line_count(chat_buf)
      vim.api.nvim_win_set_cursor(chat_win, {count, 11})
      vim.cmd('startinsert!')
    end, { buffer = chat_buf, desc = 'Clear Chat' })
  end
  
  vim.api.nvim_win_set_buf(chat_win, chat_buf)
  setup_chat_syntax()
  
  -- Wrap and scroll
  vim.api.nvim_win_set_option(chat_win, 'wrap', true)
  vim.api.nvim_win_set_option(chat_win, 'linebreak', true)
  vim.api.nvim_win_set_option(chat_win, 'breakindent', true)
  
  -- Initial prompt if empty
  if vim.api.nvim_buf_line_count(chat_buf) <= 1 then
    vim.api.nvim_buf_set_lines(chat_buf, 0, -1, false, {"**User**: "})
  end
  
  -- Move cursor to end and enter insert mode
  local count = vim.api.nvim_buf_line_count(chat_buf)
  vim.api.nvim_win_set_cursor(chat_win, {count, 11})
  vim.cmd('startinsert!')
end

local function append_to_chat(lines)
  if not chat_buf or not vim.api.nvim_buf_is_valid(chat_buf) then return end
  
  -- If lines is a string, make it a table
  if type(lines) == "string" then lines = {lines} end
  
  local last_line_idx = vim.api.nvim_buf_line_count(chat_buf) - 1
  local last_line_content = vim.api.nvim_buf_get_lines(chat_buf, last_line_idx, last_line_idx + 1, false)[1]
  
  local combined = table.concat(lines, "")
  if combined == "" then return end
  
  local split_lines = vim.split(combined, "\n", {})
  
  local new_last_line = last_line_content .. split_lines[1]
  vim.api.nvim_buf_set_lines(chat_buf, last_line_idx, last_line_idx + 1, false, {new_last_line})
  
  if #split_lines > 1 then
    local remaining = {}
    for i = 2, #split_lines do
      table.insert(remaining, split_lines[i])
    end
    vim.api.nvim_buf_set_lines(chat_buf, last_line_idx + 1, last_line_idx + 1, false, remaining)
  end
  
  -- Scroll to bottom
  if chat_win and vim.api.nvim_win_is_valid(chat_win) then
    local count = vim.api.nvim_buf_line_count(chat_buf)
    vim.api.nvim_win_set_cursor(chat_win, {count, 0})
  end
end

-- --- CORE QUERY ---

function M.query(prompt, opts)
  opts = opts or {}
  if not prompt or prompt == "" then return end
  
  ensure_chat_window()
  
  -- Visual separator
  if not opts.skip_user_label then
    append_to_chat("\n\n**User**: " .. prompt)
  end
  append_to_chat("\n\n**AIRA**: ")
  
  local args = {config.python_bin, config.script, "--stdin", "--cwd", vim.fn.getcwd(), "--session-id", config.session_id}
  
  if config.project_mode or opts.project_mode then
    table.insert(args, "--project-mode")
  end
  
  job_id = vim.fn.jobstart(args, {
    on_stdout = function(_, data, _)
      if data then
        append_to_chat(data)
      end
    end,
    on_exit = function()
      append_to_chat("\n\n**User**: ")
    end,
    stdout_buffered = false,
  })
  
  vim.fn.chansend(job_id, prompt)
  vim.fn.chanclose(job_id, "stdin")
end

-- --- PUBLIC COMMANDS ---

function M.toggle_project_mode()
  config.project_mode = not config.project_mode
  print("AIRA Project Mode: " .. tostring(config.project_mode))
end

function M.new_session()
  config.session_id = "nvim_" .. tostring(os.time()) .. "_" .. tostring(math.random(1000, 9999))
  if chat_buf and vim.api.nvim_buf_is_valid(chat_buf) then
      vim.api.nvim_buf_set_lines(chat_buf, 0, -1, false, {"--- New Session Started ---"})
  end
  print("Started new AIRA session: " .. config.session_id)
end

function M.ask_input()
  vim.ui.input({ prompt = 'Ask AIRA: ' }, function(input)
    if input then M.query(input) end
  end)
end

function M.explain_selection()
  local text = get_visual_selection()
  M.query("Explain this code:\n\n```\n" .. text .. "\n```", {title="Explain Selection"})
end

function M.refactor_selection()
  local text = get_visual_selection()
  M.query("Refactor this code to be cleaner and more efficient. Show me the code:\n\n```\n" .. text .. "\n```", {title="Refactor Selection"})
end

function M.generate_tests()
  local text = get_visual_selection()
  M.query("Write unit tests for this code:\n\n```\n" .. text .. "\n```", {title="Generate Tests"})
end

function M.fix_diagnostic()
  local err = get_current_diagnostic()
  if not err then
    print("No diagnostic found on current line.")
    return
  end
  local line_content = vim.api.nvim_get_current_line()
  M.query("Fix this error: '" .. err .. "' on line: `" .. line_content .. "`. Analyze the context and propose a fix.", {title="Fix Diagnostic"})
end

function M.complete_inline()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local lines_before = vim.api.nvim_buf_get_lines(0, 0, row, false)
  local context = table.concat(lines_before, "\n")
  
  print("AIRA: Generating completion...")
  
  local args = {
    config.python_bin, config.script, 
    "--stdin", 
    "--cwd", vim.fn.getcwd(),
    "--system", "You are a code completion engine. Continue the code provided. Return ONLY the code to be appended. No markdown, no triple backticks, no talk."
  }

  local output = ""
  local job = vim.fn.jobstart(args, {
    on_stdout = function(_, data, _)
      if data then
        for _, chunk in ipairs(data) do
          output = output .. chunk
        end
      end
    end,
    on_exit = function()
      vim.schedule(function()
        if output ~= "" then
          -- Clean up output (sometimes LLMs still add backticks)
          output = output:gsub("^```%w*\n", ""):gsub("```$", "")
          local split_output = vim.split(output, "\n")
          
          -- Insert the first line at cursor, then remaining as new lines
          vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, {split_output[1]})
          if #split_output > 1 then
            local remaining = {}
            for i = 2, #split_output do table.insert(remaining, split_output[i]) end
            vim.api.nvim_buf_set_lines(0, row, row, false, remaining)
          end
          print("AIRA: Done.")
        else
          print("AIRA: No suggestion.")
        end
      end)
    end,
    stdout_buffered = false,
  })
  
  vim.fn.chansend(job, context)
  vim.fn.chanclose(job, "stdin")
end

-- --- SETUP ---

-- User commands
vim.api.nvim_create_user_command('Aira', function(opts) M.query(opts.args) end, { nargs = '+' })
vim.api.nvim_create_user_command('AiraChat', function() ensure_chat_window() end, {})
vim.api.nvim_create_user_command('AiraToggleProject', M.toggle_project_mode, {})
vim.api.nvim_create_user_command('AiraNewSession', M.new_session, {})
vim.api.nvim_create_user_command('AiraFix', M.fix_diagnostic, {})

-- Keymaps
vim.keymap.set('n', '<leader>aa', M.ask_input, { desc = 'Ask AIRA' })
vim.keymap.set('n', '<leader>ap', function() config.project_mode = true; M.ask_input(); config.project_mode = false end, { desc = 'Ask AIRA (Project)' })
vim.keymap.set('n', '<leader>ax', M.fix_diagnostic, { desc = 'AIRA Fix Error' })
vim.keymap.set('i', '<M-\\>', M.complete_inline, { desc = 'AIRA Inline Completion' })
vim.keymap.set('n', '<leader>ai', M.complete_inline, { desc = 'AIRA Inline Completion' })

-- Visual mode keymaps
vim.keymap.set('v', '<leader>ae', M.explain_selection, { desc = 'AIRA Explain' })
vim.keymap.set('v', '<leader>ar', M.refactor_selection, { desc = 'AIRA Refactor' })
vim.keymap.set('v', '<leader>at', M.generate_tests, { desc = 'AIRA Tests' })

return M
