-- noswap
vim.o.swapfile = false
vim.o.guifont = 'JetBrainsMono NFM:h13'
vim.o.list = false

-- disable spell for pandoc
vim.api.nvim_set_var('pandoc#spell#enabled', 0)

-- markdown multi table format
vim.g.table_mode_corner_corner = '+'
vim.g.table_mode_header_fillchar = '='

-- markdown bullet and numbering indent
vim.o.breakindentopt = 'list:-1'

sysname = vim.loop.os_uname().sysname
isWindows = sysname == 'Windows_NT'
isMac = sysname == 'Darwin'
isLinux = sysname == 'Linux'

-- neovide auto focus
if vim.g.neovide then
  vim.defer_fn(function()
    vim.cmd 'NeovideFocus'
  end, 200)

  if isWindows then
    -- new neovide window in Windows
    vim.keymap.set('n', '<C-n>', ':silent !neovide<cr>', {
      desc = 'Python',
      noremap = true,
      silent = true,
    })
    vim.keymap.set('i', '<C-n>', ':silent !neovide<cr>', {
      desc = 'Python',
      noremap = true,
      silent = true,
    })
  else
    -- new neovide window in MACOS
    vim.keymap.set('n', '<D-n>', ':silent !neovide<cr>', {
      desc = 'Python',
      noremap = true,
      silent = true,
    })
    vim.keymap.set('i', '<D-n>', ':silent !neovide<cr>', {
      desc = 'Python',
      noremap = true,
      silent = true,
    })
  end
else
  -- new nvim-qt window in Android
  vim.keymap.set('n', '<M-n>', ':silent !nvim-qt<cr>', {
    desc = 'Python',
    noremap = true,
    silent = true,
  })
end

if isWindows then
  vim.g.python3_host_prog = 'C:\\Users\\yokow\\miniforge3\\envs\\labs\\python.exe'
end

-- independent clipboard
vim.opt.clipboard = ''

-- set autoindent expandtab tabstop=2 shiftwidth=2
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true

vim.o.foldlevel = 20

vim.opt.confirm = true
vim.g.have_nerd_font = true

-- Enable line numbers (both absolute and relative)
vim.wo.relativenumber = true

-- "Keep it Centered
-- Create nnoremap mappings
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', {
  noremap = true,
  silent = true,
})
vim.o.hlsearch = true

-- Toggle Spectre
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = 'Toggle Spectre. Search and Replace text in multiple files',
})

-- copilot asdasd
vim.api.nvim_set_keymap('n', '<leader>cp', ':Copilot panel<cr>', {
  noremap = true,
  silent = false,
  desc = '[C]opilot [P]anel',
})

-- save Cursor
vim.cmd [[
  autocmd BufReadPost *
        \ if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' &&
        \ line("'\"") > 1 &&
        \ line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
]]

vim.o.encoding = 'utf-8'

vim.g.markdown_fenced_languages = { 'html', 'python', 'lua', 'vim', 'typescript', 'javascript' }

-- session options
vim.opt.sessionoptions = {
  'buffers', -- save all loaded buffers
  'curdir', -- save current directory
  'tabpages', -- save tab pages
  'winsize', -- save window sizes
  'terminal', -- save terminal state
}

return {}
