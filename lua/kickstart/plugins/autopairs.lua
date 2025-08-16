-- mini.pairs - part of mini.nvim
-- More lightweight and consistent with existing mini plugins

return {
  'echasnovski/mini.pairs',
  event = 'InsertEnter',
  config = function()
    require('mini.pairs').setup()
  end,
}
