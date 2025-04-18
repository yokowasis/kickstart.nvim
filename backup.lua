vim.keymap.set('n', '<leader>pi', ':Pastify<cr>', {
    desc = '[P]aste [I]mage',
    noremap = true,
    silent = false
})

require('which-key').add {{{
    "'",
    hidden = true
}, {
    '<leader>b',
    group = '[B]ookmarks'
}, {
    '<leader>c',
    group = '[C]hat'
}, {
    '<leader>cg',
    group = '[C]hat a[G]ent'
}, -- { '<leader>d', group = '[D]atabase' },
{
    '<leader>f',
    group = '[F]ormat/[F]ramework'
}, {
    '<leader>fn',
    group = '[F]ramework [N]extJS'
}, {
    '<leader>fs',
    group = '[F]ramework [S]velte'
}, {
    '<leader>g',
    group = '[G]it'
}, {
    '<leader>j',
    group = '[J]upyter'
}, {
    '<leader>l',
    group = '[L]anguage / [L]og'
}, {
    '<leader>lc',
    group = '[L]anguage [C]hange'
}, {
    '<leader>n',
    group = '[N]eovim'
}, {
    '<leader>p',
    group = '[P]aste'
}}}

-- change language
vim.keymap.set('n', '<leader>lcj', ':set ft=javascript<cr>', {
    desc = 'Javascript',
    noremap = true,
    silent = false
})
vim.keymap.set('n', '<leader>lco', ':set ft=json<cr>', {
    desc = 'JSON',
    noremap = true,
    silent = false
})
vim.keymap.set('n', '<leader>lcp', ':set ft=php<cr>', {
    desc = 'PHP',
    noremap = true,
    silent = false
})
vim.keymap.set('n', '<leader>lch', ':set ft=html<cr>', {
    desc = 'HTML',
    noremap = true,
    silent = false
})
vim.keymap.set('n', '<leader>lcy', ':set ft=python<cr>', {
    desc = 'Python',
    noremap = true,
    silent = false
})
vim.keymap.set('n', '<leader>lcc', ':set ft=c<cr>', {
    desc = 'C',
    noremap = true,
    silent = false
})

-- jupyter
vim.keymap.set('n', '<leader>ji', ':MoltenInit<cr>', {
    noremap = true,
    silent = false,
    desc = '[J]upyter [I]nnit'
})
vim.keymap.set('n', '<leader>jr', '/```<cr><up>VN<down>:<C-u>MoltenEvaluateVisual<CR>``:noh<cr>', {
    noremap = true,
    silent = false,
    desc = '[J]upyter [R]un'
})
vim.keymap.set('n', '<leader>jo', ':noautocmd MoltenEnterOutput<CR>', {
    noremap = true,
    silent = false,
    desc = '[J]upyter Enter [O]utput'
})
vim.keymap.set('n', '<leader>jh', ':MoltenHideOutput<CR>', {
    noremap = true,
    silent = false,
    desc = '[J]upyter [H]ide Output'
})

vim.cmd [[command! EditBaseVim :tabnew | exe 'edit '. stdpath('config').'/init.lua']]
vim.cmd [[command! EditInitVim :tabnew | exe 'edit '. stdpath('config').'/lua/custom/plugins/init.lua']]
vim.cmd [[command! EditFSVim :tabnew | exe 'edit '. stdpath('config').'/lua/custom/plugins/fs.lua']]
vim.cmd [[command! LoadInitVim :tabnew | exe ':te git -C '. stdpath("config") .' pull' ]]
vim.cmd [[command! EditSnippets :lua require("luasnip.loaders").edit_snippet_files()]]

function InsertConsoleLog()
    local line_number = vim.fn.line '.'
    local current_file = '🚀 : ' .. vim.fn.expand '%:t'
    local log_statement = string.format("console.log('%s:%d');", current_file, line_number + 1)
    vim.fn.append(line_number, log_statement)
end

vim.api.nvim_set_keymap('n', '<Leader>lg', [[:lua InsertConsoleLog()<CR>]], {
    noremap = true,
    silent = true,
    desc = 'console.log file and line'
})

-- zz to esc
vim.keymap.set('i', 'zz', '<esc>', {
    silent = true,
    desc = 'escape'
})
vim.keymap.set('t', 'zz', '<C-\\><C-n>', {
    desc = '',
    noremap = true,
    silent = true
})
vim.keymap.set('v', 'zz', '<C-\\><C-n>', {
    desc = '',
    noremap = true,
    silent = true
})

-- "Database Toggle UI"
vim.keymap.set('n', '<leader>db', ':DBUIToggle<cr>', {
    desc = '[D]ata[b]ase',
    noremap = true,
    silent = true
})

function CompileAndRun()
    local filetype = GetFileType()

    -- Get full folder path of the current buffer
    local folder_path = vim.fn.expand '%:p:h'

    -- get full path up to "labs" folder
    local labs_fullfolder = folder_path:match '(.+labs)'

    -- Get the filename (with extension) of the current buffer
    local filename_with_extension = vim.fn.expand '%:t'

    -- Get the filename without the extension
    local filename_without_extension = vim.fn.expand '%:t:r'

    -- Get the file extension of the current buffer
    local file_extension = vim.fn.fnamemodify(filename_with_extension, ':e')

    if file_extension == 'cjs' or file_extension == 'mjs' then
        filetype = 'javascript'
    elseif file_extension == 'md' then
        filetype = 'markdown'
    end

    local iste = true

    if filetype == 'cpp' then
        vim.cmd(':tabnew | te g++ ' .. folder_path .. '/' .. filename_with_extension .. ' -o ' .. folder_path .. '/' ..
                    filename_without_extension .. '.out' .. ' && ' .. folder_path .. '/' .. filename_without_extension ..
                    '.out')
    elseif filetype == 'javascript' then
        vim.cmd(':tabnew | te node ' .. folder_path .. '/' .. filename_with_extension)
    elseif file_extension == 'py' then
        vim.cmd(':tabnew | te python ' .. folder_path .. '/' .. filename_with_extension)
    elseif filetype == 'typescript' then
        vim.cmd(':tabnew | te ts-node ' .. folder_path .. '/' .. filename_with_extension)
    elseif filetype == 'shell' then
        vim.cmd(':tabnew | te bash ' .. folder_path .. '/' .. filename_with_extension)
    elseif filetype == 'markdown' then
        iste = false

        local pandocCommand =
            'pandoc -F pandoc-crossref --citeproc ' .. folder_path .. '/' .. filename_with_extension .. ' -o ' ..
                filename_without_extension .. '.docx '

        if fileExists 'template.docx' then
            pandocCommand = pandocCommand .. '--reference-doc ./template.docx'
        else
            pandocCommand = pandocCommand .. '--reference-doc ' .. labs_fullfolder .. '/template/base.docx'
        end

        local extractCommand = '7z x ' .. filename_without_extension .. '.docx -o"' .. filename_without_extension .. '"'

        local xmlpath = folder_path .. '/' .. filename_without_extension .. '/word/document.xml'

        local zipCommand =
            'rm ' .. filename_without_extension .. '.docx && 7z a -tzip ' .. filename_without_extension .. '.docx ./' ..
                filename_without_extension .. '/*'

        local fixCommand = 'sed -i \'s/w:tblStyle w:val="Table"/w:tblStyle w:val="simpletable"/g\' ' .. xmlpath
        fixCommand = fixCommand .. ' && sed -i \'s/w:pStyle w:val="Bibliography"/w:pStyle w:val="DaftarPustaka"/g\' ' ..
                         xmlpath
        fixCommand = fixCommand .. ' && sed -i \'s/w:pStyle w:val="TableCaption"/w:pStyle w:val="figure"/g\' ' ..
                         xmlpath
        fixCommand = fixCommand .. ' && sed -i \'s/w:pStyle w:val="ImageCaption"/w:pStyle w:val="figure"/g\' ' ..
                         xmlpath
        fixCommand = fixCommand .. ' && sed -i \'s/w:pStyle w:val="CaptionedFigure"/w:pStyle w:val="figure"/g\' ' ..
                         xmlpath
        fixCommand = fixCommand ..
                         '&& sed -i "s|<w:p><w:pPr><w:pStyle w:val=\\"tableStyle\\" /></w:pPr><w:r><w:t xml:space=\\"preserve\\">' ..
                         'noborder</w:t></w:r></w:p><w:tbl><w:tblPr><w:tblStyle w:val=\\"simpletable\\" />|<w:tbl><w:tblPr>' ..
                         '<w:tblStyle w:val=\\"noborder\\" />|g" ' .. xmlpath

        deleteCommand = 'rm -rf ' .. filename_without_extension

        local refCommand = ''
        -- refCommand = "awk '{while(match($0, /\\#REFTABLE/)) {sub(/\\#REFTABLE/, ++count);} print}'  "
        --   .. filename_without_extension
        --   .. '/word/document.xml > temp.xml && mv temp.xml  '
        --   .. filename_without_extension
        --   .. '/word/document.xml'

        -- print(fixCommand)

        vim.cmd 'cd %:p:h'
        -- vim.cmd('!' .. deleteCommand)
        vim.cmd('!' .. pandocCommand)
        vim.cmd('!' .. extractCommand)
        vim.cmd('!' .. fixCommand)
        vim.cmd('!' .. refCommand)
        vim.cmd('!' .. zipCommand)
        vim.cmd('!' .. deleteCommand)
    else
        vim.notify('Filetype ' .. filetype .. ' not supported for compile and run')
        return
    end

    if iste then
        vim.api.nvim_feedkeys('i', 'n', true)
    end
end

return {{
    'windwp/nvim-ts-autotag',
    config = function()
        require('nvim-treesitter.configs').setup {
            sync_install = false,
            ensure_installed = '',
            ignore_install = {},
            auto_install = false,
            modules = {},
            autotag = {
                enable = true
            }
        }
    end
}, {
    'gaelph/logsitter.nvim',
    config = function()
        vim.keymap.set('n', '<leader>lg', function()
            require('logsitter').log()
        end)
    end
}, { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {{
        '<leader>ff',
        function()
            require('conform').format {
                async = true,
                lsp_fallback = true
            }
        end,
        mode = '',
        desc = '[F]ormat buffer'
    }},
    opts = {
        notify_on_error = false,
        format_after_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = {
                c = true,
                cpp = true
            }
            return {
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype]
            }
        end,
        formatters_by_ft = {
            lua = {'stylua'},
            -- Conform can also run multiple formatters sequentially
            -- python = { "isort", "black" },
            --
            -- You can use a sub-list to tell conform to run *until* a formatter
            -- is found.
            javascript = {'prettierd'},
            typescript = {'prettierd'},
            javascriptreact = {'prettierd'},
            typescriptreact = {'prettierd'},
            pandoc = {'prettierd'},
            markdown = {'prettierd'},
            json = {'prettierd'},
            css = {'prettierd'},
            yml = {'prettierd'},
            html = {'prettierd'},
            php = {'pretty-php'},
            cpp = {'clang_format'}
            -- javascript = { { 'prettierd', 'prettier' } },
        },
        formatters = {
            ['php-cs-fixer'] = {
                command = 'php-cs-fixer',
                args = {'fix', '$FILENAME'},
                stdin = false
            },
            ['djlint'] = {
                prepend_args = {'--indent', '2'}
            },
            ['pretty-php'] = {
                prepend_args = {'-s2'}
            }
        }
    }
}, {'yokowasis/vim-table-mode'}, {
    'axelvc/template-string.nvim',
    config = function()
        require('template-string').setup()
    end
}, {
    'TobinPalmer/pastify.nvim',
    cmd = {'Pastify'},
    config = function()
        require('pastify').setup {
            opts = {
                save = 'local'
            }
        }
    end
}}

