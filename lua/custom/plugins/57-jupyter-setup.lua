-- setup iron nvim

local iron = require 'iron.core'
local view = require 'iron.view'
local common = require 'iron.fts.common'

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = { 'zsh' },
      },
      python = {
        command = { 'python3' }, -- or { "ipython", "--no-autoindent" }
        format = common.bracketed_paste_python,
        block_dividers = { '# %%', '#%%' },
        env = { PYTHON_BASIC_REPL = '1' }, --this is needed for python3.13 and up.
      },
    },
    -- set the file type of the newly created repl to ft
    -- bufnr is the buffer id of the REPL and ft is the filetype of the
    -- language being used for the REPL.
    repl_filetype = function(bufnr, ft)
      return ft
      -- or return a string name such as the following
      -- return "iron"
    end,
    -- Send selections to the DAP repl if an nvim-dap session is running.
    dap_integration = true,
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = view.bottom(40),

    -- repl_open_cmd can also be an array-style table so that multiple
    -- repl_open_commands can be given.
    -- When repl_open_cmd is given as a table, the first command given will
    -- be the command that `IronRepl` initially toggles.
    -- Moreover, when repl_open_cmd is a table, each key will automatically
    -- be available as a keymap (see `keymaps` below) with the names
    -- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
    -- For example,
    --
    -- repl_open_cmd = {
    --   view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
    --   view.split.rightbelow("%25")  -- cmd_2: open a repl below
    -- }
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    toggle_repl = '<space>rr', -- toggles the repl open and closed.
    -- If repl_open_command is a table as above, then the following keymaps are
    -- available
    -- toggle_repl_with_cmd_1 = "<space>rv",
    -- toggle_repl_with_cmd_2 = "<space>rh",
    restart_repl = '<space>jr', -- calls `IronRestart` to restart the repl
    send_motion = '<space>sc',
    visual_send = '<space>sc',
    send_file = '<space>ja',
    send_line = '<space>sl',
    send_paragraph = '<space>sp',
    send_until_cursor = '<space>su',
    send_mark = '<space>sm',
    send_code_block = '<space>sb',
    send_code_block_and_move = '<space>sn',
    mark_motion = '<space>mc',
    mark_visual = '<space>mc',
    remove_mark = '<space>md',
    cr = '<space>s<cr>',
    interrupt = '<space>s<space>',
    exit = '<space>jq',
    clear = '<space>jl',
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true,
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

local function send_cell()
  local iron = require 'iron.core'

  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)[1] -- 1-based
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  local start_line = 1
  local end_line = #lines

  -- search upward for previous "# %%"
  for i = cursor, 1, -1 do
    if lines[i]:match '^# %%%%' then
      start_line = i + 1
      break
    end
  end

  -- search downward for next "# %%"
  for i = cursor + 1, #lines do
    if lines[i]:match '^# %%%%' then
      end_line = i - 1
      break
    end
  end

  if start_line > end_line then
    return
  end

  -- collect lines of the cell
  local cell_lines = vim.api.nvim_buf_get_lines(buf, start_line - 1, end_line, false)

  -- send to REPL
  iron.send(nil, cell_lines)
end

-- keymaps

vim.keymap.set('n', '<leader>jm', 'i# %%<cr>', {
  noremap = true,
  silent = false,
  desc = '[J]upyter Create [M]ark',
})

vim.keymap.set('n', '<leader>ji', ':vsplit<cr>:IronReplHere<cr><c-w><c-w>', {
  noremap = true,
  silent = false,
  desc = '[J]upyter [I]nit',
})

vim.keymap.set('v', '<leader>jv', ":lua require('iron.core').visual_send()<CR><Esc>", {
  noremap = true,
  silent = false,
  desc = '[J]upyter [V]isual Send',
})

vim.keymap.set('n', '<space>jj', send_cell, { desc = 'Iron: send current # %% cell' })

return {}
