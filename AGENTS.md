# AGENTS.md

## What this repo is

Personal Neovim configuration forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). Single `init.lua` entry point (~1106 lines), not a distribution. Config lives at `%localappdata%\nvim` (Windows).

## Upstream

Forked from nvim-lua/kickstart.nvim. This fork tracks upstream but has customizations in `init.lua`, `lua/kickstart/plugins/debug.lua`, `lua/kickstart/plugins/neo-tree.lua`, and root config files.

### Syncing with upstream

```sh
git remote add upstream https://github.com/nvim-lua/kickstart.nvim.git
git fetch upstream
git merge upstream/master --no-edit
# Resolve conflicts, then:
git add <resolved-files>
git commit --no-edit
```

**Conflict hotspots**: `init.lua` (sections 1, 4, 6, 7, 8, 9, 10), `lua/kickstart/plugins/debug.lua` (fork has JS/TS debug), `lua/kickstart/plugins/neo-tree.lua` (fork adds reveal keymap). `lua/custom/plugins/` never conflicts. `.gitignore` — upstream ignores `nvim-pack-lock.json`; this fork tracks it.

**Resolution strategy**: For `init.lua`, keep both sides. For `debug.lua`, keep fork's JS/TS additions. For `neo-tree.lua`, keep fork's reveal keymap. For `.gitignore`, prefer fork's version (track `nvim-pack-lock.json`).

### Tracking changes vs upstream

Changes outside `lua/custom/` are documented in `CHANGES.md`. Update it whenever you modify a file that also exists in upstream.

## Structure

- `init.lua` — main config, all core setup (options, keymaps, LSP, plugins, formatting, treesitter, autocomplete)
- `lua/custom/plugins/` — personal plugin configs, auto-loaded via `require 'custom.plugins'`. Files prefixed with numbers load in alphanumeric order:
  - `00-plugins.lua` — plugin registrations (flash, emmet, multicursor, grug-far, dadbod, noice/notify)
  - `01-functions.lua` — global utility functions (compile/run, git helpers, npm, session management)
  - `01-opts.lua` — personal option overrides (font, clipboard, folding, etc.)
  - `50-git.lua` — Neogit, Diffview, git keymaps and helper functions
  - `51-navigation.lua` — tabs, splits, file explorer, buffer close
  - `52-terminal.lua` — terminal keymaps (open/close/navigate)
  - `53-window.lua` — window resize keymaps
  - `55-startup.lua` — session auto-loading
  - `98-bookmarks.lua` — placeholder for bookmarks
  - `99-keymaps.lua` — all remaining keymaps (system clipboard, LSP overrides, npm, scaffold, companion, etc.)
- `lua/kickstart/plugins/` — kickstart example plugins (debug, indent_line, lint, autopairs, neo-tree, gitsigns)
- `KEYMAPS.md` — full keymap reference, grouped by category

## Plugin manager

Uses `vim.pack` (built-in Neovim plugin manager). Plugins added via `vim.pack.add()` and built via `PackChanged` autocommand. Lockfile: `nvim-pack-lock.json` (tracked in this fork).

## Commands

- `:lua vim.pack.update(nil, { offline = true })` — inspect plugin state
- `:lua vim.pack.update()` — fetch updates
- `:Mason` — manage LSP servers and tools (`g?` for help)
- `:checkhealth` — verify system setup
- `:Tutor` — Neovim tutorial
- `:PackUpdate` — custom command for `vim.pack.update(nil, { force = true })`

## Formatting

- **Lua**: stylua (config: `.stylua.toml`). Formatting is done by stylua, not lua_ls.
- **JS/TS/JSX/TSX/SCSS/Pandoc/JSON/CSS/YML/HTML**: biome (via conform.nvim)
- **Markdown**: prettierd
- **PHP**: pretty-php
- **Go**: gofumpt
- **Python**: ruff (fix + format + organize imports)
- **C/C++**: clang-format
- **Shell**: shfmt

Format-on-save is enabled for all above filetypes in conform.nvim (`init.lua:839-857`). Manual format: `<leader>ff`.

## LSP

Servers configured in `init.lua:713-771`. Mason auto-installs them. Key servers: clangd, vtsls, tailwindcss, gopls, basedpyright, rust-analyzer. Note: `lua_ls` is configured but commented out — stylua handles formatting instead.

## Testing & verification

No test suite. This is a config repo. Verify by opening Neovim and running `:checkhealth`. The `test.js` and `test.ts` files are scratch files for testing LSP/formatter.

## Gotchas

- `vim.g.mapleader = ' '` must be set before plugins load (`init.lua:98`)
- `vim.loader.enable()` is called for faster startup (`init.lua:93`)
- Nerd Font support: set `vim.g.have_nerd_font = true` in init.lua if you have one
- Snippets source is hardcoded to `~/git/friendly-snippets` path (`init.lua:933`) — adjust if your path differs
- Custom plugins use `vim.pack.add()` in `00-plugins.lua`, not inside individual plugin files
- Global utility functions are defined in `01-functions.lua` (`CompileAndRun`, `RunCommandInNewTab`, etc.) and available everywhere after init
- Clipboard is intentionally isolated from OS clipboard by default (`vim.opt.clipboard = ''` in `01-opts.lua:28`)
- Shell is hardcoded to `bash` for terminal commands (`52-terminal.lua:1`); adjust on non-Windows or if bash is not in PATH
