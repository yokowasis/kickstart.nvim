local ls = require 'luasnip'
ls.config.set_config {
  store_selection_keys = '<tab>',
}
ls.filetype_extend('svelte', { 'typescript', 'html' })

require('luasnip.loaders.from_vscode').lazy_load {
  paths = { '~/git/friendly-snippets' },
}

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if require('luasnip').choice_active() then
    require('luasnip').change_choice(1)
  end
end, { desc = 'LuaSnip: next choice' })

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  if require('luasnip').choice_active() then
    require('luasnip').change_choice(-1)
  end
end, { desc = 'LuaSnip: previous choice' })

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
require('conform').setup {
  formatters = {
    ['pretty-php'] = {
      prepend_args = { '-s2' },
    },
  },
}

require('lspconfig').clangd.setup {
  cmd = { 'clangd', '--background-index' },
}

require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = {
        name = "copilot",
        model = "gpt-4.1",
      },
      tools = {
        ["cmd_runner"] = {
          opts = {
            requires_approval = false,
          },
        },
        ["create_file"] = {
          opts = {
            requires_approval = false,
          },
        },
        ["insert_edit_into_file"] = {
          opts = {
            requires_approval = false,
            user_confirmation = false,
            patching_algorithm = "strategies.chat.tools.catalog.helpers.patch",
          },
        },
        ["fetch_webpage"] = {
          opts = {
            requires_approval = false,
          },
        },
        ["file_search"] = {
          opts = {
            requires_approval = false,
          },
        },
        ["get_changed_files"] = {
          opts = {
            requires_approval = false,
          },
        },
        ["grep_search"] = {
          opts = {
            requires_approval = false,
          },
        },
        ["list_code_usages"] = {
          opts = {
            requires_approval = false,
          },
        },
        ["next_edit_suggestion"] = {
          opts = {
            requires_approval = false,
          },
        },
        ["read_file"] = {
          opts = {
            requires_approval = false,
          },
        },
        ["search_web"] = {
          opts = {
            requires_approval = false,
          },
        },
        opts = {
          default_tools = { "full_stack_dev" },
          auto_submit_errors = true,
          auto_submit_success = true,
          folds = {
            enabled = false,
          },
          show_tools_processing = true,
        }
      }
    },
    inline = {
      adapter = {
        name = "copilot",
        model = "gpt-4.1",
      },
    },
    cmd = {
      adapter = {
        name = "copilot",
        model = "gpt-4.1",
      },
    },
  },
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_vars = true,
        make_slash_commands = true,
        show_result_in_chat = true
      }
    }
  }
})

return {}
