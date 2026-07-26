# KEYMAPS.md

Leader is `<Space>`. Source: `init.lua`, `lua/custom/plugins/`, `lua/kickstart/plugins/`.

## General

| Key                    | Mode    | Action                                      | Source     |
| ---------------------- | ------- | ------------------------------------------- | ---------- |
| `<Esc>`                | n       | Clear search highlight                      | init.lua   |
| `<C-s>`                | n, i    | Save file                                   | 99-keymaps |
| `<D-s>`                | n, i    | Save file (macOS)                           | 99-keymaps |
| `<C-v>` / `<S-insert>` | n, i, v | Paste from system clipboard                 | 99-keymaps |
| `<C-c>` / `<C-insert>` | x       | Yank to system clipboard                    | 99-keymaps |
| `<D-v>`                | i, n    | Paste from system clipboard (macOS)         | 99-keymaps |
| `x`                    | n       | Close all other windows (`:on`)             | 99-keymaps |
| `x`                    | n       | Close certain windows (help, git, qf, etc.) | 01-opts    |
| `k`                    | n       | LSP signature help                          | 99-keymaps |
| `n` / `N`              | n       | Next/prev search (centered)                 | 01-opts    |
| `<leader>?`            | n       | Show all keymaps                            | 99-keymaps |
| `<leader>cl`           | n       | Clear search highlight + remove newline     | 99-keymaps |
| `<leader>rr`           | n       | Reload resource (`:e!`)                     | 99-keymaps |

## Window Navigation

| Key     | Mode | Action           | Source   |
| ------- | ---- | ---------------- | -------- |
| `<C-h>` | n    | Move focus left  | init.lua |
| `<C-l>` | n    | Move focus right | init.lua |
| `<C-j>` | n    | Move focus down  | init.lua |
| `<C-k>` | n    | Move focus up    | init.lua |

## Window Resize

| Key | Mode | Action               | Source      |
| --- | ---- | -------------------- | ----------- |
| `.` | n    | Vertical resize -10  | 53-window   |
| `,` | n    | Vertical resize +5   | 53-window   |
| `'` | n    | Horizontal resize -5 | 53-window   |
| `;` | n    | Horizontal resize +2 | 53-window   |

## Tabs

| Key               | Mode | Action              | Source        |
| ----------------- | ---- | ------------------- | ------------- |
| `<leader><up>`    | n    | New tab             | 51-navigation |
| `<leader>tn`      | n    | New tab to the left | 51-navigation |
| `<leader><right>` | n    | Next tab            | 51-navigation |
| `<leader><left>`  | n    | Previous tab        | 51-navigation |
| `<leader><down>`  | n    | Close tab           | 51-navigation |

## Splits

| Key          | Mode | Action           | Source        |
| ------------ | ---- | ---------------- | ------------- |
| `<leader>sv` | n    | Vertical split   | 51-navigation |
| `<leader>sh` | n    | Horizontal split | 51-navigation |
| `<leader>sq` | n    | Quit window      | 51-navigation |

## File Explorer

| Key     | Mode | Action          | Source                |
| ------- | ---- | --------------- | --------------------- |
| `<C-z>` | n, i | Toggle Neo-tree | 51-navigation         |
| `\`     | n    | Neo-tree reveal | neo-tree.lua          |

## Search (Telescope)

| Key                | Mode | Action                                        | Source     |
| ------------------ | ---- | --------------------------------------------- | ---------- |
| `<leader><leader>` | n    | List buffers                                  | init.lua   |
| `<leader>sf`       | n    | Find files                                    | init.lua   |
| `<leader>sg`       | n    | Live grep                                     | 99-keymaps |
| `<leader>sc`       | n    | Live grep (custom: by extension + dir)        | 99-keymaps |
| `<leader>sw`       | n, v | Grep current word                             | init.lua   |
| `<leader>sh`       | n    | Search help                                   | init.lua   |
| `<leader>sk`       | n    | Search keymaps                                | init.lua   |
| `<leader>ss`       | n    | Telescope builtin                             | init.lua   |
| `<leader>sd`       | n    | Diagnostics                                   | init.lua   |
| `<leader>sr`       | n    | Resume last search                            | init.lua   |
| `<leader>s.`       | n    | Recent files                                  | init.lua   |
| `<leader>/`        | n    | Fuzzy find in current buffer                  | init.lua   |
| `<leader>s/`       | n    | Live grep in open files                       | init.lua   |
| `<leader>sn`       | n    | Search Neovim config files                    | init.lua   |

## LSP

| Key          | Mode | Action                       | Source   |
| ------------ | ---- | ---------------------------- | -------- |
| `grn`        | n    | Rename                       | init.lua |
| `gra`        | n, x | Code action                  | init.lua |
| `grD`        | n    | Declaration                  | init.lua |
| `grr`        | n    | References                   | init.lua |
| `gri`        | n    | Implementation               | init.lua |
| `grd`        | n    | Definition                   | init.lua |
| `grt`        | n    | Type definition              | init.lua |
| `gO`         | n    | Document symbols             | init.lua |
| `gW`         | n    | Workspace symbols            | init.lua |
| `gd`         | n    | Go to definition (Telescope) | 99-keymaps |
| `<leader>th` | n    | Toggle inlay hints           | init.lua |
| `<leader>rp` | n    | Restart LSP                  | 99-keymaps |

## Formatting

| Key           | Mode | Action                       | Source   |
| ------------- | ---- | ---------------------------- | -------- |
| `<leader>ff`  | n, v | Format buffer (conform.nvim) | init.lua |
| `<leader>fmf` | n    | Manual format (`gg=G`)       | 99-keymaps |

## Git

| Key           | Mode | Action                              | Source     |
| ------------- | ---- | ----------------------------------- | ---------- |
| `<C-e>`       | n    | Toggle Neogit status                | 50-git     |
| `<leader>gc`  | n    | Git commit                          | 50-git     |
| `<leader>gp`  | n    | Git push                            | 50-git     |
| `<leader>gu`  | n    | Git pull                            | 50-git     |
| `<leader>gd`  | n    | Neogit diff                         | 50-git     |
| `<leader>gb`  | n    | Neogit branch                       | 50-git     |
| `<leader>gv`  | n    | Diffview open                       | 50-git     |
| `<leader>gh`  | n    | File history (Telescope)            | 50-git     |
| `<leader>gl`  | n    | Git log (Telescope)                 | 50-git     |
| `<leader>ga`  | n    | Create branch and push              | 50-git     |
| `<leader>gi`  | n    | Git init + push                     | 50-git     |
| `<leader>gx`  | n    | Undo last commit                    | 50-git     |
| `<leader>gr`  | n    | Reset to commit + force push        | 50-git     |
| `<leader>coo` | n    | Checkout origin branch under cursor | 50-git     |

## Gitsigns

Gitsigns is configured inline in `init.lua` but recommended keymaps from `kickstart.plugins.gitsigns` are commented out. To enable: uncomment `require 'kickstart.plugins.gitsigns'` in `init.lua`.

| Key          | Mode | Action                    |
| ------------ | ---- | ------------------------- |
| `]c` / `[c`  | n    | Next/prev git change      |
| `<leader>hs` | n, v | Stage hunk                |
| `<leader>hr` | n, v | Reset hunk                |
| `<leader>hS` | n    | Stage buffer              |
| `<leader>hR` | n    | Reset buffer              |
| `<leader>hp` | n    | Preview hunk              |
| `<leader>hi` | n    | Preview hunk inline       |
| `<leader>hb` | n    | Blame line                |
| `<leader>hd` | n    | Diff against index        |
| `<leader>hD` | n    | Diff against last commit  |
| `<leader>hQ` | n    | Hunk quickfix (all files) |
| `<leader>hq` | n    | Hunk quickfix (this file) |
| `<leader>tb` | n    | Toggle blame line         |
| `<leader>tw` | n    | Toggle word diff          |
| `ih`         | o, x | Select hunk (text object) |

## Terminal

| Key               | Mode | Action                      | Source        |
| ----------------- | ---- | --------------------------- | ------------- |
| `<leader>\``      | n    | Open horizontal terminal    | 52-terminal   |
| `<leader>\`v`     | n    | Open vertical terminal      | 52-terminal   |
| `<leader>\``      | t    | Close terminal              | 52-terminal   |
| `<C-w><C-w>`      | t    | Switch window from terminal | 52-terminal   |
| `\\`              | t    | Exit to normal mode         | 52-terminal   |
| `<esc><esc><esc>` | t    | Exit to normal mode         | 52-terminal   |

## Debug (DAP)

| Key          | Mode | Action                     | Source   |
| ------------ | ---- | -------------------------- | -------- |
| `<F5>`       | n    | Start/continue             | debug    |
| `<F1>`       | n    | Step into                  | debug    |
| `<F10>`      | n    | Step over                  | debug    |
| `<F3>`       | n    | Step out                   | debug    |
| `<F8>`       | n    | Stop debugging             | debug    |
| `<F7>`       | n    | Toggle DAP UI              | debug    |
| `<leader>ba` | n    | Toggle breakpoint          | debug    |
| `<leader>Ba` | n    | Set conditional breakpoint | debug    |
| `<leader>bt` | n    | Toggle DAP UI              | debug    |

## Flash (Navigation)

| Key     | Mode    | Action              | Source      |
| ------- | ------- | ------------------- | ----------- |
| `s`     | n, x, o | Flash jump          | 00-plugins  |
| `S`     | n, x, o | Flash treesitter    | 00-plugins  |
| `r`     | o       | Remote flash        | 00-plugins  |
| `R`     | o, x    | Treesitter search   | 00-plugins  |
| `<C-s>` | c       | Toggle flash search | 00-plugins  |

## Multicursor

| Key             | Mode | Action                          | Source     |
| --------------- | ---- | ------------------------------- | ---------- |
| `<C-d>`         | n, x | Add cursor at next match        | 00-plugins |
| `<C-q>`         | n, x | Toggle cursor                   | 00-plugins |
| `<C-leftmouse>` | n    | Handle mouse click              | 00-plugins |
| `<leader>x`     | n, x | Delete cursor (in cursor layer) | 00-plugins |
| `<Esc>`         | n, x | Clear cursors (in cursor layer) | 00-plugins |

## Emmet

| Key     | Mode | Action              | Source     |
| ------- | ---- | ------------------- | ---------- |
| `<C-A>` | i    | Expand abbreviation | 00-plugins |

## Snippets

| Key                 | Mode | Action                        | Source   |
| ------------------- | ---- | ----------------------------- | -------- |
| `<Tab>` / `<S-Tab>` | i, s | Next/prev snippet placeholder | blink    |
| `<C-l>`             | i, s | LuaSnip next choice           | init.lua |
| `<C-h>`             | i, s | LuaSnip previous choice       | init.lua |

## Code Runner

| Key          | Mode | Action                                       | Source     |
| ------------ | ---- | -------------------------------------------- | ---------- |
| `<leader>cr` | n    | Compile and run (C++, JS, TS, Python, Shell) | 99-keymaps |
| `<leader>rb` | n    | npm run build                                | 99-keymaps |
| `<leader>rd` | n    | npm run dev (in tab)                         | 99-keymaps |
| `<leader>ri` | n    | npm/yarn/pnpm install                        | 99-keymaps |
| `<leader>rl` | n    | five-server (live server)                    | 99-keymaps |

## Search & Replace

| Key           | Mode | Action                      | Source     |
| ------------- | ---- | --------------------------- | ---------- |
| `<leader>S`   | n    | Open grug-far               | 00-plugins |
| `<leader>sar` | n, v | Search and replace          | 99-keymaps |
| `<leader>san` | v    | Search and replace N rows   | 99-keymaps |
| `<leader>svr` | v    | Search and visual replace   | 99-keymaps |
| `<leader>sk`  | v    | Search Kirby (regex replace)| 99-keymaps |
| `<c-h>`       | n    | Interactive search & replace| 99-keymaps |

## Code Scaffolding

| Key           | Mode | Action                      | Source     |
| ------------- | ---- | --------------------------- | ---------- |
| `<leader>fnp` | n    | Next.js: new page           | 99-keymaps |
| `<leader>fnr` | n    | Next.js: new API POST route | 99-keymaps |
| `<leader>fng` | n    | Next.js: new API GET route  | 99-keymaps |
| `<leader>fsp` | n    | SvelteKit: new page         | 99-keymaps |
| `<leader>fsr` | n    | SvelteKit: new POST route   | 99-keymaps |
| `<leader>fsg` | n    | SvelteKit: new GET route    | 99-keymaps |

## Code Companion (AI)

| Key          | Mode | Action           | Source     |
| ------------ | ---- | ---------------- | ---------- |
| `<leader>ct` | n    | Open chat        | 99-keymaps |
| `<leader>cc` | n, v | Inline companion | 99-keymaps |

## Database

| Key          | Mode | Action       | Source     |
| ------------ | ---- | ------------ | ---------- |
| `<leader>db` | n    | Toggle DB UI | 99-keymaps |

## Misc

| Key               | Mode    | Action                          | Source     |
| ----------------- | ------- | ------------------------------- | ---------- |
| `<leader>ww`      | n       | Toggle word wrap                | 99-keymaps |
| `<leader>bo`      | n       | Close hidden buffers            | 99-keymaps |
| `<leader>sel`     | n       | Load session                    | 99-keymaps |
| `<leader>nq`      | n       | Save session + quit             | 99-keymaps |
| `<leader>cd`      | n       | cd to current file's directory  | 99-keymaps |
| `<leader>fc`      | n       | Copy file path to clipboard     | 99-keymaps |
| `<leader>fe`      | n       | Open Explorer in file folder    | 99-keymaps |
| `<leader>sne`     | n       | Edit snippets                   | 99-keymaps |
| `<leader>snf`     | n       | Format buffer as snippet string | 99-keymaps |
| `<leader>snn`     | n       | Show Noice notifications        | 99-keymaps |
| `<leader>rx`      | n       | Install webcomponent types      | 99-keymaps |
| `<M-up>` / `<M-down>` | n   | PageUp / PageDown               | 99-keymaps |
| `<M-left>` / `<M-right>`| n,i,x | Word back/forward           | 99-keymaps |
| `<D-left>` / `<D-right>` | n,i,x | Home / End                 | 99-keymaps |
| `<D-up>` / `<D-down>`   | n,i,x | Top / Bottom of file        | 99-keymaps |
| `>` / `<`         | v       | Indent/dedent (keep visual)     | 99-keymaps |
| `<BS>`            | v, x    | Black hole delete               | 99-keymaps |
