-- "RESIZE WINDOW
vim.keymap.set('n', '.', ':vertical resize -10<cr>', {
  desc = '',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', ',', ':vertical resize +5<CR>', {
  desc = '',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', "'", ':horizontal resize -5<CR>', {
  desc = '',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', ';', ':horizontal resize +2<CR>', {
  desc = '',
  noremap = true,
  silent = true,
})

return {}
