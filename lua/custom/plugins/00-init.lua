-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
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
        enable = true, -- Enable this plugin (Can be enabled/disabled later)
        max_lines = 3, -- How many lines the window should span
        trim_scope = 'outer', -- Which context lines to discard if max_lines is exceeded
      }
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      model = 'o3-mini',
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
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
    }},
  },
  {
    'rcarriga/nvim-notify',
    config = function() -- This is the function that runs, AFTER loading
      -- Notification Setup
      require('notify').setup {
        stages = 'static',
      }
      vim.notify = require 'notify'
      function notif(jobid, data, event, timeout, notifid)
        if type(data) == 'number' then
          return
        end

        local output = table.concat(data, '\n')
        if output == '' then
        else
          vim.notify.dismiss()
          vim.notify(output, vim.log.levels.WARN, {
            title = 'Notification',
            timeout = timeout,
          })
        end
      end
    end,
  },
  { 'nvim-pack/nvim-spectre' },
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
  { 'tpope/vim-fugitive' },
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
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
}
