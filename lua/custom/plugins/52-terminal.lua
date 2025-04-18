-- "TERMINAL
vim.keymap.set('n', '<leader>``',
    ':horizontal terminal ' .. TerminalShell .. '<CR><C-w>J<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-', {
        desc = 'Open Terminal',
        noremap = false,
        silent = true
    })
vim.keymap.set('n', '<leader>`v', '<C-w>v:terminal ' .. TerminalShell .. '<CR>', {
    desc = 'Open Terminal [V]ertical',
    noremap = false,
    silent = true
})
vim.keymap.set('t', '<leader>`', '<C-\\><C-n>:q<CR>', {
    desc = '',
    noremap = true,
    silent = true
})
vim.keymap.set('t', '<C-w><C-w>', '<C-\\><C-n><C-w><C-w>', {
    desc = '',
    noremap = true,
    silent = true
})
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {
    desc = '',
    noremap = true,
    silent = true
})

TerminalShell = ''

if isWindows then
    vim.cmd [[command! SaveInitVim :tabnew | exe ':te git -C '. stdpath("config") .' add . & git -C ' . stdpath("config")  . ' commit -m save & git -C ' . stdpath("config")  . ' push']]
    vim.cmd [[command! SaveGlobalSnippets :tabnew | exe ':te git -C '. stdpath("config") .'/../../../git/friendly-snippets add . & git -C '. stdpath("config") .'/../../../git/friendly-snippets commit -m save & git -C '. stdpath("config") .'/../../../git/friendly-snippets push']]
    vim.cmd [[command! LoadGlobalSnippets :tabnew | exe ':te git -C '. stdpath("config") .'/../../../git/friendly-snippets pull']]

    TerminalShell = 'powershell'
else
    vim.cmd [[command! SaveInitVim :tabnew | exe ':te git -C '. stdpath("config") .' add . && git -C ' . stdpath("config")  . ' commit -m save && git -C ' . stdpath("config")  . ' push']]
    vim.cmd [[command! SaveGlobalSnippets :tabnew | exe ':te git -C ~/git/friendly-snippets add . && git -C ~/git/friendly-snippets commit -m save && git -C ~/git/friendly-snippets push']]
    vim.cmd [[command! LoadGlobalSnippets :tabnew | exe ':te git -C ~/git/friendly-snippets pull']]

    TerminalShell = 'bash'
end

return {}
