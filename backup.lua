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
