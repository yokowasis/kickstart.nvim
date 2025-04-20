local ls = require 'luasnip'
ls.config.set_config {
  store_selection_keys = '<tab>',
}
ls.filetype_extend('svelte', { 'typescript' })

require('luasnip.loaders.from_vscode').lazy_load {
  paths = { '~/git/friendly-snippets' },
}

require('mini.surround').setup {
  mappings = {
    add = 'ra', -- Add surrounding in Normal and Visual modes
    delete = 'rd', -- Delete surrounding
    find = 'rf', -- Find surrounding (to the right)
    find_left = 'rF', -- Find surrounding (to the left)
    highlight = 'rh', -- Highlight surrounding
    replace = 'rr', -- Replace surrounding
    update_n_lines = 'rn', -- Update `n_lines`
  },
}

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

return {}
