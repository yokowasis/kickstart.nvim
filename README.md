# kickstart-modular.nvim

A modular Neovim configuration forked from [dam9000/kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim), customized with additional plugins and workflows.

## Features

- **Modular Structure**: Configuration split across multiple files for better organization
- **LSP Support**: Full language server protocol support via nvim-lspconfig and Mason
- **Autocompletion**: blink.cmp with LuaSnip snippets
- **Fuzzy Finding**: Telescope for files, grep, buffers, and more
- **Git Integration**: Neogit with Diffview for comprehensive git workflow
- **Debugging**: DAP support for Go and C/C++
- **AI Assistance**: CodeCompanion, OpenCode, and Supermaven integrations
- **Jupyter-style REPL**: Iron.nvim for interactive Python development
- **Database UI**: vim-dadbod for database management

## Project Structure

```
~/.config/nvim/
├── init.lua                    # Entry point (leader key, requires modules)
├── lua/
│   ├── options.lua             # Neovim options
│   ├── keymaps.lua             # Basic keymaps
│   ├── lazy-bootstrap.lua      # Lazy.nvim plugin manager bootstrap
│   ├── lazy-plugins.lua        # Plugin specifications
│   ├── kickstart/
│   │   ├── health.lua          # Healthcheck
│   │   └── plugins/
│   │       ├── autopairs.lua   # Auto-pairing (mini.pairs)
│   │       ├── blink-cmp.lua   # Autocompletion
│   │       ├── conform.lua     # Code formatting
│   │       ├── debug.lua       # DAP debugging
│   │       ├── lspconfig.lua   # LSP configuration
│   │       ├── mini.lua        # mini.nvim (ai, surround, statusline)
│   │       ├── telescope.lua   # Fuzzy finder
│   │       ├── todo-comments.lua
│   │       ├── treesitter.lua  # Syntax highlighting
│   │       └── which-key.lua   # Keybinding hints
│   └── custom/
│       └── plugins/
│           ├── 00-init.lua     # Main custom plugins
│           ├── 01-opts.lua     # Custom options
│           ├── 01-functions.lua # Helper functions
│           ├── 50-git.lua      # Git keymaps and Neogit
│           ├── 51-navigation.lua # Tab/split navigation
│           ├── 52-terminal.lua # Terminal integration
│           ├── 53-window.lua   # Window resizing
│           ├── 55-startup.lua  # Session auto-loading
│           ├── 56-jupyter-plugin.lua # Iron.nvim plugin
│           ├── 57-jupyter-setup.lua  # Iron.nvim configuration
│           ├── 97-setup-plugins.lua  # Additional plugin setup
│           ├── 98-bookmarks.lua      # (Empty)
│           └── 99-keymaps.lua  # Custom keymaps
```

## Installed Plugins

### Core
- **lazy.nvim** - Plugin manager
- **nvim-treesitter** - Syntax highlighting
- **nvim-lspconfig** + **mason.nvim** - LSP support
- **blink.cmp** + **LuaSnip** - Autocompletion and snippets
- **telescope.nvim** - Fuzzy finder
- **which-key.nvim** - Keybinding hints

### UI & Appearance
- **bamboo.nvim** - Colorscheme (no italics)
- **dracula.nvim** - Alternative colorscheme
- **mini.statusline** - Status line
- **mini.indentscope** - Indent guides
- **noice.nvim** - Enhanced UI notifications
- **tiny-inline-diagnostic.nvim** - Inline diagnostics
- **nvim-treesitter-context** - Shows code context

### Navigation & Editing
- **neo-tree.nvim** - File explorer
- **flash.nvim** - Quick navigation
- **mini.ai** - Enhanced text objects
- **mini.surround** - Surround operations
- **mini.pairs** - Auto-pairing
- **multicursor.nvim** - Multiple cursors
- **grug-far.nvim** - Search and replace

### Git
- **neogit** - Git interface
- **diffview.nvim** - Diff viewer
- **mini.diff** - Git signs in gutter

### Development
- **conform.nvim** - Code formatting
- **nvim-dap** - Debugging (Go, C/C++)
- **iron.nvim** - Jupyter-style REPL
- **emmet-vim** - Emmet support
- **tailwind-tools.nvim** - Tailwind CSS support
- **guess-indent.nvim** - Auto-detect indentation

### AI & Completion
- **supermaven-nvim** - AI code completion
- **codecompanion.nvim** - AI chat assistant
- **opencode.nvim** - OpenCode integration

### Database
- **vim-dadbod** + **vim-dadbod-ui** - Database management

### Utilities
- **todo-comments.nvim** - Highlight TODOs
- **img-clip.nvim** - Paste images
- **fidget.nvim** - LSP progress
- **lazydev.nvim** - Lua development

## Installation

### Prerequisites

- Neovim 0.10+ (stable) or nightly
- Git
- A C compiler (gcc/clang)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons)
- Node.js (for TypeScript/JavaScript LSP)
- Python 3 with pip (for Python development)

### Install

```sh
# Linux/macOS
git clone https://github.com/<your_username>/kickstart-modular.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# Windows (PowerShell)
git clone https://github.com/<your_username>/kickstart-modular.nvim.git "${env:LOCALAPPDATA}\nvim"
```

Start Neovim and Lazy will automatically install all plugins:

```sh
nvim
```

### Python Dependencies (Optional)

For Jupyter/REPL and image pasting:

```bash
pip install pynvim neovim pillow
```

## Key Bindings

Leader key: `<Space>`

### General

| Keymap | Description |
|--------|-------------|
| `<C-s>` | Save file |
| `<C-v>` | Paste from system clipboard |
| `<C-c>` (visual) | Copy to system clipboard |
| `<Esc>` | Clear search highlight |
| `x` | Close other windows (`:only`) |
| `<leader>?` | Show all keymaps |

### Navigation

| Keymap | Description |
|--------|-------------|
| `<C-h/j/k/l>` | Move between windows |
| `<C-z>` | Toggle Neo-tree file explorer |
| `\` | Reveal current file in Neo-tree |
| `s` | Flash jump |
| `S` | Flash Treesitter select |

### Tabs & Splits

| Keymap | Description |
|--------|-------------|
| `<leader><up>` | New tab |
| `<leader><down>` | Close tab |
| `<leader><left>` | Previous tab |
| `<leader><right>` | Next tab |
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>sq` | Close split |

### Window Resizing

| Keymap | Description |
|--------|-------------|
| `,` | Increase width |
| `.` | Decrease width |
| `;` | Increase height |
| `'` | Decrease height |

### Search (Telescope)

| Keymap | Description |
|--------|-------------|
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep |
| `<leader>sb` | Search buffers |
| `<leader>sh` | Search help |
| `<leader>sk` | Search keymaps |
| `<leader>s.` | Recent files |
| `<leader>/` | Fuzzy search current buffer |
| `<leader><leader>` | Find buffers |

### Search & Replace

| Keymap | Description |
|--------|-------------|
| `<leader>S` | Open grug-far (search/replace) |
| `<leader>sw` | Search current word |
| `<leader>sar` | Search and replace in buffer |

### Git

| Keymap | Description |
|--------|-------------|
| `<C-e>` | Toggle Neogit status |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gu` | Git pull |
| `<leader>gb` | Git branch |
| `<leader>gd` | Git diff |
| `<leader>gl` | Git log |
| `<leader>gh` | Git file history |
| `<leader>gv` | Open Diffview |
| `<leader>gi` | Git init and push to new repo |

### LSP

| Keymap | Description |
|--------|-------------|
| `gd` | Go to definition |
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | Find references |
| `gri` | Go to implementation |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |
| `<leader>ff` | Format buffer |
| `<leader>rp` | Restart LSP |

### Debugging

| Keymap | Description |
|--------|-------------|
| `<F5>` | Start/Continue |
| `<F1>` | Step into |
| `<F2>` | Step over |
| `<F3>` | Step out |
| `<F6>` | Stop/Terminate |
| `<F7>` | Toggle DAP UI |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Set conditional breakpoint |

### Compile & Run

| Keymap | Description |
|--------|-------------|
| `<leader>cr` | Compile and run (C++, JS, Python, TS) |
| `<leader>rd` | Run `npm run dev` |
| `<leader>rb` | Run `npm run build` |
| `<leader>ri` | Run npm/yarn/pnpm install |
| `<leader>rl` | Run five-server |

### Jupyter/REPL (Iron.nvim)

| Keymap | Description |
|--------|-------------|
| `<leader>ji` | Initialize REPL |
| `<leader>jm` | Insert cell marker (`# %%`) |
| `<space>jj` | Execute current cell |
| `<space>ja` | Send entire file |
| `<space>jr` | Restart REPL |
| `<space>rr` | Toggle REPL |
| `<space>rf` | Focus REPL |
| `<space>rh` | Hide REPL |
| `<space>sl` | Send line |
| `<space>sc` | Send selection |
| `<space>jl` | Clear REPL |
| `<space>jq` | Exit REPL |

### AI Assistants

| Keymap | Description |
|--------|-------------|
| `<leader>ct` | Open CodeCompanion chat |
| `<leader>cc` | CodeCompanion with buffer |
| `<leader>ot` | Toggle OpenCode |
| `<leader>oa` | Ask OpenCode |
| `<C-j>` | Accept Supermaven suggestion |

### Multi-cursor

| Keymap | Description |
|--------|-------------|
| `<C-d>` | Add cursor at next match |
| `<C-q>` | Toggle cursor |
| `<C-leftmouse>` | Add cursor with mouse |
| `<leader>x` | Delete cursor (in multi-cursor mode) |
| `<Esc>` | Clear all cursors |

### Surround (mini.surround)

| Keymap | Description |
|--------|-------------|
| `ra` | Add surrounding |
| `rd` | Delete surrounding |
| `rr` | Replace surrounding |
| `rf` | Find surrounding |

### Terminal

| Keymap | Description |
|--------|-------------|
| `` <leader>`` `` | Open horizontal terminal |
| `` <leader>`v `` | Open vertical terminal |
| `` <leader>` `` (terminal) | Close terminal |
| `<Esc>` (terminal) | Exit terminal mode |

### Session

| Keymap | Description |
|--------|-------------|
| `<leader>nq` | Save session and quit |
| `<leader>sel` | Load session |

### Database

| Keymap | Description |
|--------|-------------|
| `<leader>db` | Toggle DBUI |

### Miscellaneous

| Keymap | Description |
|--------|-------------|
| `<leader>ww` | Toggle word wrap |
| `<leader>cd` | Change to current file directory |
| `<leader>rr` | Reload current file |
| `<leader>bo` | Close all hidden buffers |
| `<leader>fc` | Copy file path to clipboard |
| `<leader>p` | Paste image from clipboard |
| `<C-a>` (insert) | Expand Emmet abbreviation |

## Language Support

### LSP Servers (via Mason)

- **Lua**: lua_ls (via lazydev.nvim)
- **TypeScript/JavaScript**: vtsls
- **Python**: ruff, ty
- **Go**: gopls
- **Rust**: rust-analyzer
- **C/C++**: clangd (prefers system clangd if available)
- **PHP**: intelephense
- **HTML/CSS**: html, tailwindcss
- **Svelte**: svelte

### Formatters

| Language | Formatter |
|----------|-----------|
| Lua | stylua |
| JavaScript/TypeScript | prettierd |
| Python | ruff_format, ruff_fix |
| Go | gofumpt |
| C/C++ | clang-format |
| PHP | pretty-php |
| Shell | shfmt |
| HTML/CSS/JSON/Markdown | prettierd |

## Customization

### Adding Plugins

Add new plugins in `lua/custom/plugins/` - files are automatically loaded.

### Custom Snippets

Snippets are loaded from `~/git/friendly-snippets`. Edit with `:EditSnippets`.

### Configuration Commands

| Command | Description |
|---------|-------------|
| `:EditInitVim` | Edit main custom plugin file |
| `:SaveInitVim` | Commit and push config changes |
| `:LoadInitVim` | Pull latest config |
| `:Lazy` | Plugin manager UI |
| `:Mason` | LSP/tool installer UI |

## FAQ

**Q: How do I backup my existing config?**  
A: Move `~/.config/nvim` and `~/.local/share/nvim` to backup locations before installing.

**Q: How do I run this alongside another config?**  
A: Use `NVIM_APPNAME`:
```sh
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
```

**Q: How do I uninstall?**  
A: See [lazy.nvim uninstall docs](https://lazy.folke.io/usage#-uninstalling).

## Platform-Specific Notes

### Windows

- Uses PowerShell as terminal shell
- Requires Visual Studio Build Tools or MinGW for native compilation
- See `:checkhealth` for any issues

### macOS

- Supports Neovide with `<D-...>` (Cmd) keybindings
- iTerm2 keybinding setup documented in `lua/custom/plugins/readme.md`

### Termux (Android)

- Mason skips clangd installation (use system clangd)
- Some features may be limited

## License

MIT - See [LICENSE.md](LICENSE.md)
