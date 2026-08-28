# CHANGES.md

Tracks changes made in this fork compared to upstream [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Only covers changes outside `lua/custom/` (personal plugins are not listed here).

Last synced with upstream: **2026-07-26**

---

## init.lua

### Options (Section 1)

- **Nerd Font**: `vim.g.have_nerd_font = true` (upstream: `false`)
- **Clipboard**: disabled (`unnamedplus` line commented out)
- **Terminal exit keymap**: `<Esc><Esc>` in terminal mode commented out (upstream has it active; terminal keymaps now live in `lua/custom/plugins/52-terminal.lua`)
- **Window navigation**: `<C-h>/<C-j>/<C-k>/<C-l>` focus keymaps commented out (upstream has them active)
- **Relativenumber**: set additionally via `vim.wo.relativenumber = true` in `01-opts.lua` (upstream: commented out)

### UI Plugins (Section 4)

- **mini.surround**: custom keymaps (`ra`/`rd`/`rf`/`rF`/`rh`/`rr`/`rn`) instead of defaults
- **Colorscheme**: rose-pine (`rose-pine-main`) active; aura-theme, tokyonight, kanagawa also registered

### Telescope (Section 5)

- **file_ignore_patterns**: added `node_modules`, `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`, `lazy-lock.json`
- **Insert-mode mappings**: `<C-e>` closes the picker, `<C-D>` selects in new tab, `<C-Up>`/`<C-Down>` scroll preview
- **`<leader>sf` / `<leader>sg`**: configured with `layout_strategy = 'vertical'` except sg and map `<CR>` to `select_tab`, so results open in a new Neovim tab

### LSP Servers (Section 6)

- **clangd**: enabled with `--background-index` and `--query-driver` (upstream: commented out)
- **vtsls**: enabled (upstream: commented out `ts_ls`)
- **tailwindcss**: enabled for TSX/JSX/HTML/CSS/Svelte (upstream: not configured)
- **lua_ls**: disabled in favor of stylua for formatting

### Mason Tools (Section 6)

Added to `ensure_installed`: `vtsls`, `tailwindcss`, `html`, `intelephense`, `pretty-php`, `svelte`, `gofumpt`, `gopls`, `shfmt`, `biome`, `prettierd`, `js-debug-adapter`.
Commented out (install manually): `basedpyright`, `rust-analyzer`, `ruff`, `clang-format`.
Note: upstream only installs `stylua`; this fork installs significantly more.

### Formatting (Section 7)

- **Format-on-save**: enabled for Lua, JS, TS, JSX, TSX, SCSS, Pandoc, Markdown, JSON, CSS, YML, HTML, PHP, CPP, SH, Go, Python (upstream: commented out)
- **Formatters**: biome for JS/TS/JSX/TSX/SCSS/Pandoc/JSON/CSS/YML/HTML, prettierd for Markdown, pretty-php with `-s2` arg, clang-format, shfmt, gofumpt, stylua for Lua, ruff (fix + format + organize imports) for Python
- **Format keymap**: `<leader>ff` (upstream: `<leader>f`)

### Autocomplete (Section 8)

- **LuaSnip**: added `store_selection_keys = '<tab>'`, `filetype_extend('svelte', ...)`, custom snippet loader path (`~/git/friendly-snippets`), and `<C-l>`/`<C-h>` choice-change keymaps
- **blink.cmp**: keymap preset changed from `'default'` to `'enter'`, added custom `<C-x>` toggle mapping, dadbod completion provider for SQL/MySQL/PLSQL, and `signature = { enabled = false }`

### Treesitter (Section 9)

- **Compilers**: added `require('nvim-treesitter.install').compilers = { 'clang', 'gcc', 'zig' }`
- **Parsers**: added `svelte`, `jsx`, `tsx`, `json`, `sql`, and others to ensured parsers

### Examples (Section 10)

- Uncommented `require 'kickstart.plugins.*'` lines (debug, indent_line, lint, autopairs, neo-tree)
- `kickstart.plugins.gitsigns` remains commented out (gitsigns configured inline in Section 4)
- Uncommented `require 'custom.plugins'`

---

## lua/kickstart/plugins/debug.lua

- **keymaps**: `<F10>` for step_over (upstream: `<F2>`), `<leader>ba`/`<leader>Ba`/`<leader>bt` for breakpoint/UI (upstream: `<leader>b`/`<leader>B`)
- **js-debug-adapter**: added to `ensure_installed`
- **JS/TS debugging**: entire section added — adapters (`pwa-node`, `pwa-chrome`, `node_terminal`, `chrome`) and configurations for Next.js server/client debugging (languages: `typescript`, `javascript`, `typescriptreact`, `javascriptreact`)

---

## lua/kickstart/plugins/neo-tree.lua

- **Reveal keymap**: `\` maps to `Neotree reveal` (upstream: not present; Neo-tree is commented out upstream)

---

## Root files

- **dprint.json**: added (not in upstream). Configures dprint with TypeScript, JSON, Markdown, TOML, Malva, Markup, and YAML plugins.
- **KEYMAPS.md**: added (not in upstream). Full keymap reference grouped by category. Notes that git is Telescope-based and Neogit/Diffview are not used.
- **AGENTS.md**: added (not in upstream). AI assistant instructions for working with this config.
- **CHANGES.md**: this file (not in upstream). Tracks fork changes.
