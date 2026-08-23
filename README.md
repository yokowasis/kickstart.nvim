# nvim

Personal Neovim configuration forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Features

- **Single-file** `init.lua` entry point (~1180 lines) — modular custom plugins in `lua/custom/plugins/`
- **Plugin manager**: built-in `vim.pack` (no lazy.nvim, no packer)
- **LSP**: clangd, vtsls, gopls, basedpyright, rust-analyzer, tailwindcss, intelephense, svelte — auto-installed via Mason
- **Format on save**: stylua (Lua), biome (JS/TS/JSX/TSX/CSS/JSON/YML/HTML), ruff (Python), pretty-php, clang-format, shfmt, gofumpt, prettierd (Markdown)
- **Autocomplete**: blink.cmp with LuaSnip + friendly-snippets + dadbod-completion (`$TM_SELECTED_TEXT` support via `<Tab>` in visual mode)
- **Debugging**: nvim-dap with JS/TS/Next.js client/server configurations
- **Navigation**: Telescope (results open in new tabs), flash.nvim, Neo-tree
- **Git**: Telescope-based git pickers + git helper commands
- **AI**: Copilot + CodeCompanion
- **Database**: vim-dadbod + dadbod-ui + vim-dadbod-completion
- **Session management**: auto-load/save per-project `.vim` sessions

## Installation

```powershell
# Clone to %localappdata%\nvim
git clone https://github.com/yokowasis/nvim.git "$env:LOCALAPPDATA\nvim"
```

```cmd
REM or with cmd.exe
git clone https://github.com/yokowasis/nvim.git "%localappdata%\nvim"
```

Start Neovim and run `:checkhealth`. All plugins auto-install via `vim.pack` hooks. LSP servers and formatters install via `:Mason`.

## Requirements

- Neovim >= 0.11 (stable or nightly)
- `git`, `make`, C compiler (`gcc`/`clang`)
- [ripgrep](https://github.com/BurntSushi/ripgrep), [fd](https://github.com/sharkdp/fd)
- [Nerd Font](https://www.nerdfonts.com/) (JetBrainsMono NF recommended)
- `bash` in PATH (for terminal and compile/run commands)
- Language-specific: Node.js, Go, Rust, Python, PHP (as needed)

## Treesitter (Windows)

On Windows, Treesitter needs a CLI compiler to build parsers.

1. Install the CLI globally:
   ```sh
   npm i -g tree-sitter-cli
   ```
2. Treesitter looks for `cl.exe` to compile parsers, so copy `gcc.exe` to `cl.exe` (e.g. into your MinGW/GCC `bin` directory, or anywhere on `PATH`):
   ```sh
   cp /mingw64/bin/gcc.exe /mingw64/bin/cl.exe
   ```

Run `:TSInstall <language>` (or `:checkhealth treesitter`) to verify.

## Structure

```
init.lua                  # Main config — options, LSP, formatting, autocomplete, treesitter
lua/
  custom/plugins/
    00-plugins.lua        # Plugin registrations (flash, emmet, multicursor, grug-far, dadbod, noice, copilot)
    01-functions.lua      # Global utility functions (search_and_replace, CompileAndRun, npm helpers, git helpers)
    01-opts.lua           # Personal option overrides (font, clipboard, folding, winborder, session, fold save)
    50-git.lua            # Telescope-based git pickers, git helper functions
    51-navigation.lua     # Tabs, splits, file explorer, buffer close
    52-terminal.lua       # Terminal keymaps and shell configuration
    53-window.lua         # Window resize
    55-startup.lua        # Session auto-loading
    98-bookmarks.lua      # Bookmarks placeholder
    99-keymaps.lua        # All remaining keymaps
  kickstart/plugins/      # Upstream example plugins
    debug.lua             # nvim-dap + JS/TS/Next.js debug configs
    neo-tree.lua          # File explorer with reveal keymap
    indent_line.lua, lint.lua, autopairs.lua
```

## Keymaps

See [KEYMAPS.md](KEYMAPS.md) for the full reference (Leader is `<Space>`).

## Custom Commands

- `:PackUpdate` — force update all plugins (`vim.pack.update(nil, { force = true })`)
- `:GrugFar` — open grug-far search and replace
- `:GitInitPush` — create GitHub repo and push from current directory

## Snippets

Snippets come from [friendly-snippets](https://github.com/rafamadriz/friendly-snippets), stored at `~/git/friendly-snippets`. Custom snippets live there too.

**`$TM_SELECTED_TEXT` workflow:**

1. Select text in visual mode
2. Press `<Tab>` (LuaSnip stores the selection)
3. Expand a snippet (e.g. `/**` for JSDoc, `\textbf{}` for LaTeX bold)
4. `$TM_SELECTED_TEXT` is replaced with your selection

Configure at `init.lua:941-942` (`store_selection_keys = '<tab>'`).

## Syncing with Upstream

```sh
git remote add upstream https://github.com/nvim-lua/kickstart.nvim.git
git fetch upstream
git merge upstream/master --no-edit
```

- Resolve the conflict
- git add .
- git config --global core.editor nvim
- git rebase --continue
- git push --force-with-lease origin master

See [AGENTS.md](AGENTS.md) for conflict resolution strategy and [CHANGES.md](CHANGES.md) for the diff vs upstream.
