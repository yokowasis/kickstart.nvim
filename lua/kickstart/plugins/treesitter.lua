return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install {
        'rust',
        'zig',
        'bash',
        'c',
        'cpp',
        'python',
        'tsx',
        'jsx',
        'javascript',
        'typescript',
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
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
