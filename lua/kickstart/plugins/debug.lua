-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
  'https://github.com/leoluz/nvim-dap-go',
}

local dap_configured = false
local function ensure_dap_setup()
  if dap_configured then
    return
  end
  dap_configured = true

  local dap = require 'dap'
  local dapui = require 'dapui'

  require('mason-nvim-dap').setup {
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_installation = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    -- You'll need to check that you have the required things installed
    -- online, please don't ask me how to install them :)
    ensure_installed = {
      'delve',
      'js-debug-adapter',
    },
  }

  -- Dap UI setup
  -- For more information, see |:help nvim-dap-ui|
  ---@diagnostic disable-next-line: missing-fields
  dapui.setup {
    -- Set icons to characters that are more likely to work in every terminal.
    --    Feel free to remove or use ones that you like more! :)
    --    Don't feel like these are good choices.
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    ---@diagnostic disable-next-line: missing-fields
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }

  -- Change breakpoint icons
  -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
  -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
  -- local breakpoint_icons = vim.g.have_nerd_font
  --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
  --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
  -- for type, icon in pairs(breakpoint_icons) do
  --   local tp = 'Dap' .. type
  --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
  -- end

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  -- Install golang specific config
  require('dap-go').setup {
    delve = {
      -- On Windows delve must be run attached or it crashes.
      -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
      detached = vim.fn.has 'win32' == 0,
    },
  }

  -- ==========================================
  -- JavaScript / TypeScript / Next.js Setup
  -- ==========================================

  -- 1. Define the adapters using the js-debug-adapter installed by Mason
  -- We use the direct path to dapDebugServer.js to avoid PATH/binary linking issues.
  local js_debug_adapter_path = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'packages', 'js-debug-adapter', 'js-debug', 'src', 'dapDebugServer.js')

  local node_terminal = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = {
        js_debug_adapter_path,
        '${port}',
      },
    },
  }

  local chrome = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = {
        js_debug_adapter_path,
        '${port}',
      },
    },
  }

  dap.adapters['pwa-node'] = node_terminal
  dap.adapters['node_terminal'] = node_terminal

  dap.adapters['pwa-chrome'] = chrome
  dap.adapters['chrome'] = chrome

  -- 2. Define configurations for TS/JS
  local js_based_languages = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'svelte' }
  local chrome_runtime = vim.fn.has 'win32' == 0
      and (vim.fn.executable '/usr/local/bin/chromedev.sh' == 1 and '/usr/local/bin/chromedev.sh' or '/usr/bin/google-chrome')
    or nil

  for _, language in ipairs(js_based_languages) do
    dap.configurations[language] = {
      -- Launch current file with Node
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Nvim: Launch Current File (Node)',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
      -- Server-side Next.js debugging
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Nvim: Debug JS Server',
        runtimeExecutable = 'npm',
        runtimeArgs = { 'run', 'dev' },
        cwd = '${workspaceFolder}',
        -- 'integratedTerminal' launches a Neovim terminal split and runs the command there
        console = 'integratedTerminal',
        -- sourceMaps = true, -- Uncomment if breakpoints in `.next` aren't mapping correctly
      },
      -- Client-side Next.js debugging
      {
        type = 'pwa-chrome',
        request = 'launch',
        name = 'Nvim: Debug JS Client',
        url = 'http://localhost:3000',
        webRoot = '${workspaceFolder}',
        runtimeExecutable = chrome_runtime,
        -- By default, pwa-chrome uses a clean, isolated Chrome profile.
        -- Uncomment the line below if you want it to use your default Chrome profile (so you can use your extensions).
        -- userDataDir = false,
        -- sourceMaps = true,
      },
      -- Attach to an already-running Chrome instance (e.g. chrome-dev on :9222)
      {
        type = 'pwa-chrome',
        request = 'attach',
        name = 'Nvim: Attach to Chrome',
        address = 'localhost',
        port = 9222,
        webRoot = '${workspaceFolder}',
      },
    }
  end
end

local function dap_map(lhs, fn, desc)
  vim.keymap.set('n', lhs, function()
    ensure_dap_setup()
    fn()
  end, { desc = desc })
end

-- Basic debugging keymaps, feel free to change to your liking!
dap_map('<F5>', function() require('dap').continue() end, 'Debug: Start/Continue')
dap_map('<F1>', function() require('dap').step_into() end, 'Debug: Step Into')
dap_map('<F10>', function() require('dap').step_over() end, 'Debug: Step Over')
dap_map('<F3>', function() require('dap').step_out() end, 'Debug: Step Out')
dap_map('<leader>ba', function() require('dap').toggle_breakpoint() end, 'Debug: Toggle Breakpoint')
dap_map('<leader>Ba', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, 'Debug: Set Breakpoint')
dap_map('<leader>bt', function() require('dapui').toggle() end, 'Debug: Toggle UI')
dap_map('<F8>', function() require('dap').terminate() end, 'Debug: Stop Debugging')

-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
dap_map('<F7>', function() require('dapui').toggle() end, 'Debug: See last session result.')
