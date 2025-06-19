local ls = require 'luasnip'
ls.config.set_config {
  store_selection_keys = '<tab>',
}
ls.filetype_extend('svelte', { 'typescript', 'html' })

require('luasnip.loaders.from_vscode').lazy_load {
  paths = { '~/git/friendly-snippets' },
}

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if require("luasnip").choice_active() then
    require("luasnip").change_choice(1)
  end
end, { desc = "LuaSnip: next choice" })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if require("luasnip").choice_active() then
    require("luasnip").change_choice(-1)
  end
end, { desc = "LuaSnip: previous choice" })

-- close window with x if it's not a main window
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'checkhealth', 'fugitive*', 'git', 'help', 'lspinfo', 'netrw', 'notify', 'qf', 'query' },
  callback = function()
    vim.keymap.set('n', 'x', vim.cmd.close, {
      desc = 'Close the current buffer',
      buffer = true,
    })
  end,
})

-- Folding settings
vim.opt.foldmethod = 'indent'

require('nvim-treesitter.install').compilers = { 'clang', 'gcc', 'zig' }

-- save folded state
local viewdir = vim.fn.stdpath 'state' .. '/view'

vim.o.viewdir = viewdir
vim.o.viewoptions = 'cursor,folds' -- only save cursor + folds (not options, etc.)

-- Create the view directory if it doesn't exist
vim.fn.mkdir(viewdir, 'p')

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
    vim.cmd 'silent! loadview'
  end,
})

require('guess-indent').setup {}
require("conform").setup({
  formatters = {
    [ "pretty-php" ] = {
      prepend_args = { "-s2" },
    },
  },
})
require("ibl").setup()

return {}
