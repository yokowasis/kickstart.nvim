-- noswap
vim.o.swapfile = false
vim.o.guifont = 'JetBrainsMono NFM:h14:sb'
vim.o.list = false

-- disable spell for pandoc
vim.api.nvim_set_var('pandoc#spell#enabled', 0)

-- markdown multi table format
vim.g.table_mode_corner_corner = '+'
vim.g.table_mode_header_fillchar = '='

-- markdown bullet and numbering indent
vim.o.breakindentopt = 'list:-1'

-- lsp border
vim.o.winborder = 'rounded'

sysname = vim.loop.os_uname().sysname
isWindows = sysname == 'Windows_NT'
isMac = sysname == 'Darwin'
isLinux = sysname == 'Linux'

-- neovide auto focus
if vim.g.neovide then
  vim.defer_fn(function() vim.cmd 'NeovideFocus' end, 200)

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

-- auto cd to current directory
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.isdirectory(vim.fn.expand("%:p")) == 0 then
      vim.cmd("cd %:p:h")
    end
  end,
})

if isWindows then vim.g.python3_host_prog = 'C:\\Users\\yokow\\miniforge3\\envs\\labs\\python.exe' end

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

vim.api.nvim_set_keymap('n', '<leader>cpr', ':CphReceive<cr>', {
  noremap = true,
  silent = false,
  desc = '[C]ompetitive [P]rogramming [R]eceive',
})

vim.api.nvim_set_keymap('n', '<leader>cpt', ':CphTest<cr>', {
  noremap = true,
  silent = false,
  desc = '[C]ompetitive [P]rogramming [T]est',
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


-- Folding
vim.o.foldmethod = 'indent'

-- Save folds between sessions
local viewdir = vim.fn.stdpath 'state' .. '/view'
vim.o.viewdir = viewdir
vim.o.viewoptions = 'cursor,folds'
vim.fn.mkdir(viewdir, 'p')

-- Close certain windows with x
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'checkhealth', 'fugitive*', 'git', 'help', 'lspinfo', 'netrw', 'notify', 'qf', 'query' },
  callback = function()
    vim.keymap.set('n', 'x', vim.cmd.close, {
      desc = 'Close the current buffer',
      buffer = true,
    })
  end,
})

-- Remember folds between sessions
vim.api.nvim_create_augroup('remember_folds', { clear = true })
vim.api.nvim_create_autocmd('BufWinLeave', {
  group = 'remember_folds',
  pattern = '*',
  callback = function()
    vim.cmd 'silent! mkview'
  end,
})
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = 'remember_folds',
  pattern = '*',
  callback = function()
    pcall(vim.cmd, 'silent! loadview')
  end,
})

return {}
