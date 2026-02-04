return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      require('nvim-treesitter').install {
        'jsx',
        'tsx',
        'javascript',
        'typescript',
        'rust',
        'zig',
        'bash',
        'c',
        'cpp',
        'python',
        'vimdoc',
        'vim',
        'lua',
        'php',
        'html',
        'svelte',
        'markdown',
        'markdown_inline',
        'yaml',
        'json',
      }

      -- Enable treesitter highlighting for all installed languages
      -- This is required in the new version of nvim-treesitter
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'javascriptreact',
          'typescriptreact',
          'javascript',
          'typescript',
          'rust',
          'zig',
          'bash',
          'c',
          'cpp',
          'python',
          'vim',
          'lua',
          'php',
          'html',
          'svelte',
          'markdown',
          'yaml',
          'json',
        },
        callback = function()
          vim.treesitter.start()
        end,
        desc = 'Enable treesitter highlighting',
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
