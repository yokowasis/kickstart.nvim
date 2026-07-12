-- =============================================================================
-- PLUGIN REGISTRATIONS
-- =============================================================================
vim.pack.add({
  { src = 'https://github.com/folke/flash.nvim' },
  { src = 'https://github.com/yokowasis/emmet-vim' },
  {
    src = 'https://github.com/jake-stewart/multicursor.nvim',
    version = '1.0',
  },
  { src = 'https://github.com/MagicDuck/grug-far.nvim' },
  { src = 'https://github.com/tpope/vim-dadbod' },
  { src = 'https://github.com/kristijanhusak/vim-dadbod-ui' },
  { src = 'https://github.com/kristijanhusak/vim-dadbod-completion' },
  { src = 'https://github.com/thesimonho/kanagawa-paper.nvim' },
})

-- =============================================================================
-- FLASH NAVIGATION
-- =============================================================================
require("flash").setup({})

vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })

vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })

vim.keymap.set("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })

vim.keymap.set({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

vim.keymap.set("c", "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- =============================================================================
-- EMMET
-- =============================================================================
vim.g.user_emmet_settings = {
  typescriptreact = {
    attribute_name = {
      ["class"] = "class",
    },
  },
}

-- =============================================================================
-- MULTICURSOR
-- =============================================================================
local mc = require("multicursor-nvim")
mc.setup()

local set = vim.keymap.set

set({ "n", "x" }, "<c-d>", function()
  mc.matchAddCursor(1)
end)

set("n", "<c-leftmouse>", mc.handleMouse)
set("n", "<c-leftdrag>", mc.handleMouseDrag)
set("n", "<c-leftrelease>", mc.handleMouseRelease)

set({ "n", "x" }, "<c-q>", mc.toggleCursor)

mc.addKeymapLayer(function(layerSet)
  layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

  layerSet("n", "<esc>", function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
end)

local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { reverse = true })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorMatchPreview", { link = "Search" })
hl(0, "MultiCursorDisabledCursor", { reverse = true })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })

-- =============================================================================
-- GRUG-FAR (SEARCH & REPLACE)
-- =============================================================================
require("grug-far").setup({
  headerMaxWidth = 80,
})

vim.api.nvim_create_user_command("GrugFar", function()
  require("grug-far").open()
end, {})

local set = vim.keymap.set

set("n", "<leader>S", "<cmd>GrugFar<cr>", { desc = "Search and Replace (grug-far)" })

-- set("n", "<leader>sw", function()
--   require("grug-far").grug_far({ prefills = { search = vim.fn.expand("<cword>") } })
-- end, { desc = "Search current word" })

-- set("n", "<leader>sf", function()
--   require("grug-far").grug_far({ prefills = { paths = vim.fn.expand("%") } })
-- end, { desc = "Search in current file" })

-- =============================================================================
-- DADBOD (DATABASE TOOLS)
-- =============================================================================
vim.g.db_ui_use_nerd_fonts = 1

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    vim.fn["compe#register"]({ source = "vim-dadbod-completion" })
  end,
})

-- =============================================================================
-- KANAGAWA-PAPER COLORSCHEME
-- =============================================================================
require("kanagawa-paper").setup({})

vim.cmd("colorscheme kanagawa-paper-ink")
