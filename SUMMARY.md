# Neovim Configuration Summary

## Core Setup
- **Base**: kickstart-modular.nvim with custom plugins in `lua/custom/plugins/`
- **Theme**: Bamboo (no italics)
- **Git**: Neogit + Diffview (replaced fugitive)
- **Navigation**: Flash.nvim (`s`/`S` for jumping)
- **Search/Replace**: Grug-far (`<leader>S`)
- **Notifications**: Noice.nvim (top-right mini notifications)

## Key Plugins
- **Git**: `NeogitTab` (`<C-e>`), comprehensive branch keymaps (`<leader>gb*`)
- **Mini.nvim**: pairs, diff, statusline, indentscope
- **LLM**: OpenCode (`<leader>o*`) + CodeCompanion
- **File manager**: Neo-tree (`\`)
- **Emmet**: nvim-emmet (`<C-y>,`)
- **Multi-cursor**: multicursor.nvim (`<C-d>`)
- **Images**: img-clip (`<leader>p`)

## Optimizations Made
- Removed bloat: mini.animate, mini.starter, mini.tabline, mini.map, mini.extra
- Replaced autopairs → mini.pairs, indent-blankline → mini.indentscope
- Replaced spectre → grug-far, leap → flash
- Fixed noice flashing by calling git functions directly
- Disabled gitsigns/tokyonight (using mini.diff/bamboo instead)

## LLM Merge Rules
See README.md for conflict resolution priorities when merging upstream changes.