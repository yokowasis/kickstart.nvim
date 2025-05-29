-- "Tab Navigation
vim.keymap.set('n', '<leader><up>', ':tabnew<CR>', {
  desc = 'New Tab',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<leader>tn', ':-1tabnew<CR>', {
  desc = 'New Tab To The Left',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<leader><right>', ':tabnext<CR>', {
  desc = 'Next Tab',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<leader><left>', ':tabprevious<CR>', {
  desc = 'Previous Tab',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<leader><down>', ':tabclose<CR>', {
  desc = 'Close Tab',
  noremap = true,
  silent = true,
})

-- nerdtree
vim.keymap.set('n', '<c-z>', ':Neotree reveal<cr>', {
  desc = 'Show File Explorer',
  noremap = true,
  silent = true,
})
vim.keymap.set('i', '<c-z>', '<c-o>:Neotree reveal<cr>', {
  desc = 'Show File Explorer',
  noremap = true,
  silent = true,
})

return {}
