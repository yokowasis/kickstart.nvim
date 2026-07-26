TerminalShell = ''

vim.cmd [[command! LoadInitVim :tabnew | exe ':te git -C '. stdpath("config") .' pull' ]]
vim.cmd [[command! EditInitVim :tabnew | exe 'edit '. stdpath('config').'/lua/custom/plugins/00-init.lua']]
vim.cmd [[command! EditSnippets :lua require("luasnip.loaders").edit_snippet_files()]]

-- open terminal
vim.keymap.set('n', '<leader>``', ':horizontal terminal ' .. TerminalShell .. '<CR><C-w>J<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-', {
  desc = 'Open Terminal',
  noremap = false,
  silent = true,
})

-- vertical terminal
vim.keymap.set('n', '<leader>`v', '<C-w>v:terminal ' .. TerminalShell .. '<CR>', {
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
