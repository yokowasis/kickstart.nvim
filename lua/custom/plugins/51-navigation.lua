-- Smart ZQ function: close split → buffer → neovim
local function smart_zq()
  -- Get window count
  local win_count = vim.fn.winnr('$')
  
  -- If multiple windows/splits, just close current window
  if win_count > 1 then
    vim.cmd('quit')
    return
  end
  
  -- Only one window left, check buffer count
  local buffers = vim.fn.getbufinfo({buflisted = 1})
  local listed_buffers = {}
  
  -- Count only listed buffers (exclude help, quickfix, etc.)
  for _, buf in ipairs(buffers) do
    if buf.listed == 1 then
      table.insert(listed_buffers, buf)
    end
  end
  
  -- If this is the last buffer, quit Neovim
  if #listed_buffers <= 1 then
    vim.cmd('quit')
  else
    vim.cmd('bdelete')
  end
end

-- Smart buffer delete function (for <leader><down>)
local function smart_buffer_delete()
  local buffers = vim.fn.getbufinfo({buflisted = 1})
  local listed_buffers = {}
  
  -- Count only listed buffers (exclude help, quickfix, etc.)
  for _, buf in ipairs(buffers) do
    if buf.listed == 1 then
      table.insert(listed_buffers, buf)
    end
  end
  
  -- If this is the last buffer, quit Neovim
  if #listed_buffers <= 1 then
    vim.cmd('quit')
  else
    vim.cmd('bdelete')
  end
end

-- "Buffer Navigation
vim.keymap.set('n', '<leader><up>', ':enew<CR>', {
  desc = 'New Empty Buffer',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<leader>tn', ':-1tabnew<CR>', {
  desc = 'New Tab To The Left',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<leader><right>', ':bnext<CR>', {
  desc = 'Next Buffer',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<leader><left>', ':bprevious<CR>', {
  desc = 'Previous Buffer',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<leader><down>', smart_buffer_delete, {
  desc = 'Delete Buffer (Quit if Last)',
  noremap = true,
  silent = true,
})

-- Bind smart ZQ
vim.keymap.set('n', 'ZQ', smart_zq, {
  desc = 'Smart Close: Split→Buffer→Neovim',
  noremap = true,
  silent = true,
})

-- Window splitting
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', {
  desc = '[S]plit [V]ertical',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<leader>sh', ':split<CR>', {
  desc = '[S]plit [H]orizontal',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<leader>sq', '<C-w>q', {
  desc = '[S]plit [Q]uit Window',
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
