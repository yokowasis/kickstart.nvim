vim.deprecate = function() end

-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { '<leader>p', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['<c-z>'] = 'close_window',
          },
        },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    config = function()
      require('treesitter-context').setup {
        enable = true,
        max_lines = 3,
        trim_scope = 'outer',
      }
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  {
    'echasnovski/mini.statusline',
    event = 'VeryLazy',
    config = function()
      require('mini.statusline').setup { use_icons = vim.g.have_nerd_font }
    end,
  },
  {
    'mattn/emmet-vim',
    init = function()
      vim.g.user_emmet_settings = {
        typescriptreact = {
          attribute_name = {
            ['class'] = 'class', -- override className -> class
          },
        },
      }
    end,
  },
  {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    config = function()
      local mc = require 'multicursor-nvim'
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      -- set({"n", "x"}, "<c-d>", function() mc.lineAddCursor(-1) end)
      -- set({ 'n', 'x' }, '<c-d>', function()
      --   mc.lineAddCursor(1)
      -- end)
      -- set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end)
      -- set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ 'n', 'x' }, '<c-d>', function()
        mc.matchAddCursor(1)
      end)
      -- set({ 'n', 'x' }, '<leader>s', function()
      --   mc.matchSkipCursor(1)
      -- end)
      -- set({ 'n', 'x' }, '<leader>N', function()
      --   mc.matchAddCursor(-1)
      -- end)
      -- set({ 'n', 'x' }, '<leader>S', function()
      --   mc.matchSkipCursor(-1)
      -- end)

      -- Add and remove cursors with control + left click.
      set('n', '<c-leftmouse>', mc.handleMouse)
      set('n', '<c-leftdrag>', mc.handleMouseDrag)
      set('n', '<c-leftrelease>', mc.handleMouseRelease)

      -- Disable and enable cursors.
      set({ 'n', 'x' }, '<c-q>', mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        -- layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
        -- layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ 'n', 'x' }, '<leader>x', mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet('n', '<esc>', function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, 'MultiCursorCursor', { reverse = true })
      hl(0, 'MultiCursorVisual', { link = 'Visual' })
      hl(0, 'MultiCursorSign', { link = 'SignColumn' })
      hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
      hl(0, 'MultiCursorDisabledCursor', { reverse = true })
      hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
      hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
    end,
  },
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        -- optional configuration here
        code_style = {
          comments = {
            italic = false,
          },
          conditionals = {
            italic = false,
          },
          keywords = {
            italic = false,
          },
          functions = {
            italic = false,
          },
          namespaces = {
            italic = false,
          },
          parameters = {
            italic = false,
          },
          strings = {
            italic = false,
          },
          variables = {
            italic = false,
          },
        },
        highlights = {
          -- Remove underlines from tag-related groups
          ['htmlLink'] = { fg = '$blue' },
          ['@markup.link.label.html'] = { fg = '$blue' },
          ['@string.special.url.html'] = { fg = '$orange' },
          -- TSX/JSX related
          ['@_jsx_element.tsx'] = { fg = '$blue' },
          ['@_jsx_element'] = { fg = '$blue' },
          ['@none.tsx'] = { fg = '$blue' },
          ['@spell.tsx'] = { fg = '$blue' },
          ['@markup.link.label.tsx'] = { fg = '$blue' },
          -- JavaScript/JSX related
          ['@_jsx_element.javascript'] = { fg = '$blue' },
          ['@none.javascript'] = { fg = '$blue' },
          ['@spell.javascript'] = { fg = '$blue' },
          ['@markup.link.label.javascript'] = { fg = '$blue' },
        },
      }
      require('bamboo').load()
    end,
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
  {
    'echasnovski/mini.indentscope',
    event = 'VeryLazy',
    config = function()
      require('mini.indentscope').setup {
        symbol = '│',
        options = { try_as_border = true },
      }
    end,
  },

  {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    ---@type opencode.Config
    opts = {
      -- Your configuration, if any
    },
    -- stylua: ignore
    keys = {
      { '<leader>ot', function() require('opencode').toggle() end, desc = 'Toggle embedded opencode', },
      { '<leader>oa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = 'n', },
      { '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
      { '<leader>op', function() require('opencode').select_prompt() end, desc = 'Select prompt', mode = { 'n', 'v', }, },
      { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New session', },
      { '<leader>oy', function() require('opencode').command('messages_copy') end, desc = 'Copy last message', },
      { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end, desc = 'Scroll messages up', },
      { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    tag = 'v17.33.0', -- Pin to stable version to avoid breaking changes
    dependencies = {
      'ravitemer/mcphub.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  --   ft = { 'markdown', 'codecompanion' },
  -- },
  {
    'echasnovski/mini.diff',
    config = function()
      local diff = require 'mini.diff'
      diff.setup {
        -- Enable git source
        source = diff.gen_source.git(),
        view = {
          style = 'sign', -- Show git changes in sign column
          signs = { add = '+', change = '~', delete = '-' },
        },
      }
    end,
  },
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup {
        headerMaxWidth = 80,
      }
    end,
    cmd = 'GrugFar',
    keys = {
      { '<leader>S', '<cmd>GrugFar<cr>', desc = 'Search and Replace (grug-far)' },
      {
        '<leader>sw',
        function()
          require('grug-far').grug_far { prefills = { search = vim.fn.expand '<cword>' } }
        end,
        desc = 'Search current word',
      },
      {
        '<leader>sf',
        function()
          require('grug-far').grug_far { prefills = { paths = vim.fn.expand '%' } }
        end,
        desc = 'Search in current file',
      },
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          -- ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          -- ['vim.lsp.util.stylize_markdown'] = true,
          -- ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      views = {
        mini = {
          size = {
            width = 'auto',
            height = 'auto',
          },
          border = {
            style = 'rounded',
          },
          win_options = {
            winblend = 10,
          },
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- optional
      'neovim/nvim-lspconfig', -- optional
    },
    opts = {}, -- your configuration
  },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<c-j>',
          accept_word = '<>',
        },
      }
    end,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
