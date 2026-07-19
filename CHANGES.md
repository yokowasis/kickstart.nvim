# CHANGES.md

Tracks changes made in this fork compared to upstream [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Only covers changes outside `lua/custom/` (personal plugins are not listed here).

Last synced with upstream: **2026-07-19**

---

## init.lua

### Options (Section 1)

- **Nerd Font**: `vim.g.have_nerd_font = true` (upstream: `false`)
- **Clipboard**: disabled (upstream enables `unnamedplus` on startup)
- **Terminal exit keymap**: `<Esc><Esc>` in terminal mode commented out (upstream has it active)

### UI Plugins (Section 4)

- **mini.surround**: custom keymaps (`ra`/`rd`/`rf`/`rF`/`rh`/`rr`/`rn`) instead of defaults

### Telescope (Section 5)

- **file_ignore_patterns**: added `node_modules`, `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`, `lazy-lock.json`

### LSP Servers (Section 6)

- **clangd**: enabled with `--background-index` (upstream: commented out)
- **vtsls**: enabled (upstream: commented out `ts_ls`)
- **tailwindcss**: enabled for TSX/JSX/HTML/CSS (upstream: not configured)

### Mason Tools (Section 6)

Added to `ensure_installed`: `tailwindcss`, `html`, `intelephense`, `pretty-php`, `svelte`, `vtsls`, `gofumpt`, `gopls`, `shfmt`, `rust-analyzer`, `ruff`, `biome`, `clang-format`

### Formatting (Section 7)

- **Format-on-save**: enabled for JS, TS, JSX, TSX, SCSS, Pandoc, Markdown, JSON, CSS, YML, HTML, PHP, CPP, SH, Go, Python (upstream: commented out)
- **Formatters**: biome for JS/TS/JSON/CSS/HTML/YAML/Markdown, pretty-php with `-s2` arg, clang-format, shfmt, gofumpt, ruff (fix + format + organize imports)

### Autocomplete (Section 8)

- **LuaSnip**: added `store_selection_keys = '<tab>'`, `filetype_extend('svelte', ...)` , custom snippet loader path (`~/git/friendly-snippets`)
- **blink.cmp**: keymap preset changed from `'default'` to `'enter'`, added custom `<C-x>` toggle mapping

### Treesitter (Section 9)

- **Compilers**: added `require('nvim-treesitter.install').compilers = { 'clang', 'gcc', 'zig' }`

### Examples (Section 10)

- Uncommented `require 'kickstart.plugins.*'` lines (debug, indent_line, lint, autopairs, neo-tree)
- Uncommented `require 'custom.plugins'`

---

## lua/kickstart/plugins/debug.lua

- **keymaps**: `<F10>` for step_over (upstream: `<F2>`), `<leader>ba`/`<leader>Ba`/`<leader>bt` for breakpoint/UI (upstream: `<leader>b`/`<leader>B`)
- **js-debug-adapter**: added to `ensure_installed`
- **JS/TS debugging**: entire section added — adapters (`pwa-node`, `pwa-chrome`, `node_terminal`, `chrome`) and configurations for Next.js server/client debugging

---

## Root files

- **dprint.json**: added (not in upstream). Configures dprint with TypeScript, JSON, Markdown, TOML, Malva, Markup, and YAML plugins.
- **KEYMAPS.md**: added (not in upstream). Full keymap reference grouped by category.
