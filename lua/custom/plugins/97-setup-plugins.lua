-- nvimtree setup
local function my_on_attach(bufnr)
    local api = require 'nvim-tree.api'

    local function opts(desc)
        return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', 't', api.node.open.tab, opts 'Open: New Tab')
    vim.keymap.set('n', 'v', api.node.open.vertical, opts 'Open: Vertical Split')
    vim.keymap.set('n', 'x', api.node.open.horizontal, opts 'Open: Horizontal Split')
    vim.keymap.set('n', 'm', api.fs.rename_full, opts 'Rename: Full Path')
end

local ls = require 'luasnip'
ls.config.set_config {
    store_selection_keys = '<tab>'
}
ls.filetype_extend('svelte', {'typescript'})

require('nvim-treesitter.install').compilers = {'clang', 'gcc', 'zig'}

require('mini.surround').setup {
    mappings = {
        add = 'ra', -- Add surrounding in Normal and Visual modes
        delete = 'rd', -- Delete surrounding
        find = 'rf', -- Find surrounding (to the right)
        find_left = 'rF', -- Find surrounding (to the left)
        highlight = 'rh', -- Highlight surrounding
        replace = 'rr', -- Replace surrounding
        update_n_lines = 'rn' -- Update `n_lines`
    }
}

-- close window with x if it's not a main window
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'checkhealth', 'fugitive*', 'git', 'help', 'lspinfo', 'netrw', 'notify', 'qf', 'query'},
    callback = function()
        vim.keymap.set('n', 'x', vim.cmd.close, {
            desc = 'Close the current buffer',
            buffer = true
        })
    end
})

require('luasnip.loaders.from_vscode').lazy_load {
    paths = {'~/git/friendly-snippets'}
}

return {}

