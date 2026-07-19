# AGENTS.md

## What this repo is

Personal Neovim configuration based on kickstart.nvim. Single `init.lua` entry point, not a distribution. Config lives at `%localappdata%\nvim` (Windows).

## Upstream

Forked from [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). This fork tracks the upstream but has local customizations in `init.lua`, `lua/kickstart/plugins/debug.lua`, and root config files (`dprint.json`).

### Syncing with upstream

```sh
# Add upstream remote (one-time)
git remote add upstream https://github.com/nvim-lua/kickstart.nvim.git

# Fetch and merge upstream changes
git fetch upstream
git merge upstream/master --no-edit

# If conflicts occur, resolve them then:
git add <resolved-files>
git commit --no-edit
```

**Conflict hotspots** (files both sides edit):
- `init.lua` — the big one. Sections 1 (options), 4 (UI plugins), 6 (LSP servers), 7 (formatting), 8 (autocomplete), 9 (treesitter), 10 (examples) all differ.
- `lua/kickstart/plugins/debug.lua` — fork has JS/TS debugging; upstream only has Go.
- `lua/custom/plugins/` — never conflicts (your own code, not in upstream).
- `.gitignore` — upstream ignores `nvim-pack-lock.json`; your fork may not.

**Resolution strategy**: For `init.lua`, keep both sides. Upstream changes bring new features/fixes; your changes bring personal preference. For `debug.lua`, keep the fork's additions (JS/TS debug). For `.gitignore`, prefer your fork's version (track `nvim-pack-lock.json`).

### Tracking changes vs upstream

Changes not in `lua/custom/` are documented in `CHANGES.md`. Update it whenever you modify a file that also exists in upstream.

## Structure

- `init.lua` — main config, ~1100 lines, all core setup (options, keymaps, LSP, plugins, formatting, treesitter)
- `lua/custom/plugins/` — personal plugin configs, auto-loaded by `init.lua` via `require 'custom.plugins'`. Files prefixed with numbers load in order (e.g. `00-plugins.lua` runs first)
- `lua/kickstart/plugins/` — example plugins from kickstart (debug, indent_line, lint, autopairs, neo-tree, gitsigns)
- `KEYMAPS.md` — full keymap reference, grouped by category

## Plugin manager

Uses `vim.pack` (built-in Neovim plugin manager, not lazy.nvim or packer). Plugins are added via `vim.pack.add()` and built via the `PackChanged` autocommand. Lockfile: `nvim-pack-lock.json` (gitignored in upstream; track it in your fork).

## Commands

- `:lua vim.pack.update(nil, { offline = true })` — inspect plugin state
- `:lua vim.pack.update()` — fetch updates
- `:Mason` — manage LSP servers and tools (`g?` for help)
- `:checkhealth` — verify system setup
- `:Tutor` — Neovim tutorial

## Formatting

- **Lua**: stylua (config: `.stylua.toml`). Formatting is done by stylua, not lua_ls.
- **JS/TS/JSON/CSS/HTML/Markdown/YAML**: biome (via conform.nvim)
- **PHP**: pretty-php
- **Go**: gofumpt
- **Python**: ruff (fix + format + organize imports)
- **C/C++**: clang-format
- **Shell**: shfmt

Format-on-save is enabled for specific filetypes in `conform.nvim` (init.lua:819-845). Manual format: `<leader>f`.

## LSP

Servers configured in `init.lua:710-763`. Mason auto-installs them. Key servers: clangd, vtsls, tailwindcss, stylua, lua_ls. Note: `lua_ls` has `documentFormattingProvider = false` since stylua handles formatting.

## Testing & verification

No test suite. This is a config repo. Verify by opening Neovim and running `:checkhealth`. The `test.js` and `test.ts` files are scratch files for testing LSP/formatter.

## Gotchas

- `vim.g.mapleader = ' '` must be set before plugins load (init.lua:98)
- `vim.loader.enable()` is called for faster startup (init.lua:93)
- Nerd Font support: set `vim.g.have_nerd_font = true` in init.lua if you have one
- Snippets source is hardcoded to `~/git/friendly-snippets` path (init.lua:915) — adjust if your path differs
- Custom plugins use `vim.pack.add()` in `00-plugins.lua`, not inside individual plugin files
