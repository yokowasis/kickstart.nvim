-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {{
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
        modes = {
            search = {
                enabled = false
            }
        }
    },
    -- stylua: ignore
    keys = {{
        "s",
        mode = {"n", "o", "x"},
        function()
            require("flash").jump()
        end,
        desc = "Flash"
    }, {
        "S",
        mode = {"n", "o", "x"},
        function()
            require("flash").treesitter()
        end,
        desc = "Flash Treesitter"
    }, {
        "r",
        mode = "o",
        function()
            require("flash").remote()
        end,
        desc = "Remote Flash"
    }, {
        "R",
        mode = {"o", "x"},
        function()
            require("flash").treesitter_search()
        end,
        desc = "Treesitter Search"
    }, {
        "<c-s>",
        mode = {"c"},
        function()
            require("flash").toggle()
        end,
        desc = "Toggle Flash Search"
    }}
}, {
    'rcarriga/nvim-notify',
    config = function() -- This is the function that runs, AFTER loading
        -- Notification Setup
        require('notify').setup {
            stages = 'static'
        }
        vim.notify = require 'notify'
        function notif(jobid, data, event, timeout, notifid)
            local output = table.concat(data, '\n')
            if output == '' then
            else
                vim.notify.dismiss()
                vim.notify(output, vim.log.levels.WARN, {
                    title = 'Notification',
                    timeout = timeout
                })
            end
        end
    end
}, 'nvim-pack/nvim-spectre', {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        require('nvim-tree').setup {
            actions = {
                open_file = {
                    quit_on_open = true
                }
            },
            update_focused_file = {
                enable = true
            },
            git = {
                enable = false
            },
            sort = {
                sorter = 'case_sensitive'
            },
            view = {
                width = 30
            },
            renderer = {
                group_empty = true
            },
            on_attach = my_on_attach,
            filters = {
                dotfiles = false
            }
        }
    end
}, 'mattn/emmet-vim', 'tpope/vim-fugitive', {
    'yokowasis/multicursors.nvim',
    event = 'VeryLazy',
    dependencies = {'yokowasis/hydra.nvim'},
    opts = {},
    cmd = {'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor'},
    keys = {{
        mode = {'v', 'n'},
        '<Leader>m',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selected text or word under the cursor'
    }}
}, {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('bamboo').setup {
            -- optional configuration here
            code_style = {
                comments = {
                    italic = false
                },
                conditionals = {
                    italic = false
                },
                keywords = {
                    italic = false
                },
                functions = {
                    italic = false
                },
                namespaces = {
                    italic = false
                },
                parameters = {
                    italic = false
                },
                strings = {
                    italic = false
                },
                variables = {
                    italic = false
                }
            }
        }
        require('bamboo').load()
    end
}}
