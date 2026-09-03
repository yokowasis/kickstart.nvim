default_terminal = 'bash'

vim.o.shell = default_terminal

if isLinux then vim.o.shell = 'bash' end

if isWindows then vim.o.shell = 'cmd.exe' end

-- open terminal
vim.keymap.set('n', '<leader>``', ':horizontal terminal ' .. default_terminal .. ' <CR><C-w>J<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-', {
  desc = 'Open Terminal',
  noremap = false,
  silent = true,
})

-- open terminal fullscreen
vim.keymap.set('n', '<leader>`f', ':tab terminal ' .. default_terminal .. '<CR>i', {
  desc = 'Open Fullscreen Terminal',
  noremap = false,
  silent = true,
})

-- vertical terminal
vim.keymap.set('n', '<leader>`v', '<C-w>v:terminal ' .. default_terminal .. ' <CR>', {
  desc = 'Open Terminal [V]ertical',
  noremap = false,
  silent = true,
})

-- close terminal
vim.keymap.set('t', '<leader>`', '<C-\\><C-n>:q<CR>', {
  desc = '',
  noremap = true,
  silent = true,
})

-- switch window
vim.keymap.set('t', '<C-w><C-w>', '<C-\\><C-n><C-w><C-w>', {
  desc = '',
  noremap = true,
  silent = true,
})

-- backslash twice to normal mode in terminal
vim.keymap.set('t', '\\\\', '<C-\\><C-n>', {
  desc = 'Exit terminal mode (\\\\ sequence)',
  noremap = true,
  silent = true,
})

vim.keymap.set('t', '<esc><esc><esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal mode (\\\\ sequence)',
  noremap = true,
  silent = true,
})

return {}
