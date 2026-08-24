-- Notification function for job output
function notif(jobid, data, event, timeout, notifid)
  if type(data) == 'number' then return end

  local output = table.concat(data, '\n')
  if output ~= '' then vim.notify(output, vim.log.levels.WARN, {
    title = 'Notification',
    timeout = timeout or 5000,
  }) end
end

function cmd_to_run(command)
  local cmd_to_run = command
  if type(command) == 'string' then cmd_to_run = { vim.o.shell, vim.o.shellcmdflag, command } end
  return cmd_to_run
end

-- livegrep search
function customSearchGrep()
  local extension = vim.fn.input 'Enter File Extension (*): '
  local dirs = vim.fn.input 'Enter Search Directories (.): '

  -- if escape is pressed, return
  if extension == '' and dirs == '' then return end

  if extension == '' then extension = '*' end
  if dirs == '' then dirs = '.' end

  vim.cmd('Telescope live_grep glob_pattern=*.{' .. extension .. '} search_dirs=' .. dirs)
end

function SearchAndReplace(search, replace)
  -- make sure search is not empty
  if search == '' then return end

  local command = ':%s/' .. search .. '/' .. replace .. '/g'
  local termcodes = vim.api.nvim_replace_termcodes(command, true, true, true)
  vim.api.nvim_feedkeys(termcodes, 'n', true)
end

local function apply_case(matched, replacement)
  if #matched == 0 or #replacement == 0 then return replacement end

  -- 1. All uppercase match -> All uppercase replacement
  if matched:match '%a' and matched:upper() == matched then return replacement:upper() end

  -- 2. Titlecase match (e.g., "Foo") -> Titlecase replacement ("Something")
  if #matched > 1 and matched:sub(1, 1):match '%u' and matched:sub(2):match '^%l+$' then return replacement:sub(1, 1):upper() .. replacement:sub(2):lower() end

  -- 3. All lowercase match -> All lowercase replacement
  if matched:match '%a' and matched:lower() == matched then return replacement:lower() end

  -- 4. Mixed-case (e.g., "FOo" -> "SOmething", "fOO" -> "sOMething"):
  local result = {}
  local matched_len = #matched
  local repl_len = #replacement

  for i = 1, repl_len do
    local repl_char = replacement:sub(i, i)
    if i <= matched_len then
      local match_char = matched:sub(i, i)
      if match_char:match '%u' then
        table.insert(result, repl_char:upper())
      elseif match_char:match '%l' then
        table.insert(result, repl_char:lower())
      else
        table.insert(result, repl_char)
      end
    else
      table.insert(result, repl_char)
    end
  end

  return table.concat(result)
end

local function replace_in_line(line, search_term, replace_term)
  if search_term == '' then return line end
  local search_lower = search_term:lower()
  local line_lower = line:lower()

  local result = {}
  local last_pos = 1

  while true do
    local match_start, match_end = line_lower:find(search_lower, last_pos, true)
    if not match_start then
      table.insert(result, line:sub(last_pos))
      break
    end

    if match_start > last_pos then table.insert(result, line:sub(last_pos, match_start - 1)) end

    local matched_text = line:sub(match_start, match_end)
    local preserved_replace = apply_case(matched_text, replace_term)
    table.insert(result, preserved_replace)

    last_pos = match_end + 1
  end

  return table.concat(result)
end

function search_and_replace(line_affected, search, replace)
  if not search or search == '' then return end
  line_affected = tonumber(line_affected) or 1
  if line_affected < 0 then return end
  replace = replace or ''

  local bufnr = 0
  local total_lines = vim.api.nvim_buf_line_count(bufnr)
  local start_row, end_row

  if line_affected == 0 then
    start_row = 0
    end_row = total_lines
  else
    local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1
    start_row = cursor_row
    end_row = math.min(start_row + line_affected, total_lines)
  end

  if start_row >= total_lines then return end

  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row, false)
  local updated_lines = {}

  for _, line in ipairs(lines) do
    table.insert(updated_lines, replace_in_line(line, search, replace))
  end

  vim.api.nvim_buf_set_lines(bufnr, start_row, end_row, false, updated_lines)
end

function Run_dev()
  local package_json_exists = vim.fn.filereadable 'package.json' == 1
  local dev_sh_exists = vim.fn.filereadable 'dev.sh' == 1

  if package_json_exists then
    RunCommandInBackgroundTab 'npm run dev'
  elseif dev_sh_exists then
    RunCommandInBackgroundTab 'bash dev.sh'
  end
end

function GetFileType()
  local filename = vim.fn.expand '%:t'
  local extension = vim.fn.fnamemodify(filename, ':e')

  if extension == 'js' or extension == 'jsx' then
    return 'javascript'
  elseif extension == 'ts' or extension == 'tsx' then
    return 'typescript'
  elseif extension == 'cpp' or extension == 'c' then
    return 'cpp'
  elseif extension == 'sh' then
    return 'shell'
  else
    return 'unknown'
  end
end

function fileExists(fileName)
  local file = io.open(fileName, 'r')
  if file then
    file:close()
    return true
  else
    return false
  end
end

function BuildAndNotify()
  vim.notify('Building Project...', vim.log.levels.INFO, {
    title = 'NPM',
    timeout = 36000000,
  })

  vim.fn.jobstart(cmd_to_run 'npm run build', {
    on_stdout = function(id, data, e) notif(id, data, e, 4000) end,
    on_stderr = function(id, data, e) notif(id, data, e, 4000) end,
    on_exit = function(id, data, e) notif(id, data, e, 4000) end,
  })
end

function LoadInitVim()
  RunCommandAndNotify('git -C ~/git/friendly-snippets pull', 5000, 'Updating Friendly Snippets')
  RunCommandAndNotify('git -C ~/git/api-key pull', 5000, 'Updating Api Key')
  if isWindows then
    RunCommandAndNotify('git -C ~/AppData/Local/nvim pull', 5000, 'Updating Neovim Config')
  else
    RunCommandAndNotify('git -C ~/.config/nvim pull', 5000, 'Updating Neovim Config')
  end
end

vim.api.nvim_create_user_command('LoadInitVim', LoadInitVim, {})

function RunCommandInNewTab(command)
  vim.cmd 'tabnew'

  if isWindows then
    local term_id = vim.fn.jobstart('bash.exe', { term = true })
    vim.api.nvim_chan_send(term_id, vim.fn.escape(command, '\\') .. ' && exit\r')
  else
    local term_id = vim.fn.jobstart(vim.o.shell .. ' -i', { term = true })
    vim.api.nvim_chan_send(term_id, command .. ' && exit\r')
  end
end

function RunCommandInNewLeftTab(command)
  vim.cmd '-tabnew'

  local term_id = vim.fn.jobstart(vim.o.shell .. ' -i', { term = true })
  vim.api.nvim_chan_send(term_id, command .. ' && exit\r')
end

function RunCommandInBackgroundTab(command)
  local current = vim.api.nvim_get_current_tabpage()

  vim.cmd '-tabnew'

  local term_id = vim.fn.jobstart(vim.o.shell .. ' -i', { term = true })
  vim.api.nvim_chan_send(term_id, command .. ' && exit\r')

  -- Go back to the original tab
  vim.api.nvim_set_current_tabpage(current)
end

function RunCommandAndNotify(command, timeout, title)
  if timeout == nil then timeout = 5000 end
  if title == nil then title = 'Run Command' end

  vim.notify(title, vim.log.levels.INFO, {
    title = title,
    timeout = timeout,
  })

  vim.fn.jobstart(cmd_to_run(command), {
    -- Kept your original callbacks exactly as they were
    on_stdout = function(id, data, e) notif(id, data, e, 4000) end,
    on_stderr = function(id, data, e) notif(id, data, e, 4000) end,
    on_exit = function(id, data, e) notif(id, data, e, 4000) end,
  })
end

function CloseHiddenBuffers()
  local all_buffers = vim.api.nvim_list_bufs()
  local visible_buffers = {}
  local closed_count = 0

  -- Get all visible buffers from all tabs and windows
  for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
      local buf = vim.api.nvim_win_get_buf(win)
      visible_buffers[buf] = true
    end
  end

  -- Close buffers that are not visible in any window
  for _, buf in ipairs(all_buffers) do
    if not visible_buffers[buf] and vim.api.nvim_buf_is_loaded(buf) then
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name ~= '' and not vim.api.nvim_buf_get_option(buf, 'modified') then
        vim.api.nvim_buf_delete(buf, { force = false })
        closed_count = closed_count + 1
      end
    end
  end

  vim.notify('Closed ' .. closed_count .. ' hidden buffers', vim.log.levels.INFO, {
    title = 'Buffer Cleanup',
    timeout = 2000,
  })
end

vim.api.nvim_create_user_command('PackUpdate', function() vim.pack.update(nil, { force = true }) end, {})

return {}
