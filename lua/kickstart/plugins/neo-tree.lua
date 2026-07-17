-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  filesystem = {
    follow_current_file = {
      enabled = true,          -- This finds and focuses the file in the active buffer every time a new file is opened
      leave_dirs_open = false, -- Closes folders when you leave them (set to true if you prefer keeping them open)
    },
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
  },
}
