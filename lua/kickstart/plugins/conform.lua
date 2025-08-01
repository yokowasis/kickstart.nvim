return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>ff',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_after_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            async = true,
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        scss = { 'prettierd' },
        pandoc = { 'prettierd' },
        markdown = { 'prettierd' },
        json = { 'prettierd' },
        css = { 'prettierd' },
        yml = { 'prettierd' },
        html = { 'prettierd' },
        php = { 'pretty-php' },
        cpp = { 'clang_format' },
        sh = { 'shfmt' },
        go = { "gofumpt" },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
