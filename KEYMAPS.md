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
| `x`                    | n       | Close all other windows (`:on`)             | 99-keymaps |
| `x`                    | n       | Close certain windows (help, git, qf, etc.) | 01-opts    |
| `k`                    | n       | LSP signature help                          | 99-keymaps |
| `n` / `N`              | n       | Next/prev search (centered)                 | 01-opts    |

## Window Navigation

| Key     | Mode | Action           |
| ------- | ---- | ---------------- |
| `<C-h>` | n    | Move focus left  |
| `<C-l>` | n    | Move focus right |
| `<C-j>` | n    | Move focus down  |
| `<C-k>` | n    | Move focus up    |

## Window Resize

| Key | Mode | Action               |
| --- | ---- | -------------------- |
| `.` | n    | Vertical resize -10  |
| `,` | n    | Vertical resize +5   |
| `'` | n    | Horizontal resize -5 |
| `;` | n    | Horizontal resize +2 |

## Tabs

| Key               | Mode | Action              |
| ----------------- | ---- | ------------------- |
| `<leader><up>`    | n    | New tab             |
| `<leader>tn`      | n    | New tab to the left |
| `<leader><right>` | n    | Next tab            |
| `<leader><left>`  | n    | Previous tab        |
| `<leader><down>`  | n    | Close tab           |

## Splits

| Key          | Mode | Action           |
| ------------ | ---- | ---------------- |
| `<leader>sv` | n    | Vertical split   |
| `<leader>sh` | n    | Horizontal split |
| `<leader>sq` | n    | Quit window      |

## File Explorer

| Key     | Mode | Action          |
| ------- | ---- | --------------- |
| `<C-z>` | n, i | Toggle Neo-tree |
| `\`     | n    | Neo-tree reveal |

## Search (Telescope)

| Key                | Mode | Action                                        |
| ------------------ | ---- | --------------------------------------------- |
| `<leader><leader>` | n    | List buffers                                  |
| `<leader>sf`       | n    | Find files                                    |
| `<leader>sg`       | n    | Live grep                                     |
| `<leader>sc`       | n    | Live grep (custom: by extension + dir)        |
| `<leader>sw`       | n, v | Grep current word                             |
| `<leader>sh`       | n    | Search help                                   |
| `<leader>sk`       | n    | Search keymaps                                |
| `<leader>ss`       | n    | Telescope builtin                             |
| `<leader>sd`       | n    | Diagnostics                                   |
| `<leader>sr`       | n    | Resume last search                            |
| `<leader>s.`       | n    | Recent files                                  |
| `<leader>sc`       | n    | Commands                                      |
| `<leader>/`        | n    | Fuzzy find in current buffer                  |
| `<leader>s/`       | n    | Live grep in open files                       |
| `<leader>sn`       | n    | Search Neovim config files                    |
| `<leader>?`        | n    | Show all keymaps                              |
| `<leader>cl`       | n    | Clear search highlight + remove newline chars |

## LSP

| Key          | Mode | Action                       |
| ------------ | ---- | ---------------------------- |
| `grn`        | n    | Rename                       |
| `gra`        | n, x | Code action                  |
| `grD`        | n    | Declaration                  |
| `grr`        | n    | References                   |
| `gri`        | n    | Implementation               |
| `grd`        | n    | Definition                   |
| `grt`        | n    | Type definition              |
| `gO`         | n    | Document symbols             |
| `gW`         | n    | Workspace symbols            |
| `gd`         | n    | Go to definition (Telescope) |
| `<leader>th` | n    | Toggle inlay hints           |
| `<leader>rp` | n    | Restart LSP                  |

## Formatting

| Key           | Mode | Action                       |
| ------------- | ---- | ---------------------------- |
| `<leader>f`   | n, v | Format buffer (conform.nvim) |
| `<leader>fmf` | n    | Manual format (`gg=G`)       |

## Git

| Key           | Mode | Action                              |
| ------------- | ---- | ----------------------------------- |
| `<C-e>`       | n    | Toggle Neogit status                |
| `<leader>gc`  | n    | Git commit                          |
| `<leader>gp`  | n    | Git push                            |
| `<leader>gu`  | n    | Git pull                            |
| `<leader>gd`  | n    | Neogit diff                         |
| `<leader>gb`  | n    | Neogit branch                       |
| `<leader>gv`  | n    | Diffview open                       |
| `<leader>gh`  | n    | File history (Telescope)            |
| `<leader>gl`  | n    | Git log (Telescope)                 |
| `<leader>ga`  | n    | Create branch and push              |
| `<leader>gi`  | n    | Git init + push                     |
| `<leader>gx`  | n    | Undo last commit                    |
| `<leader>gr`  | n    | Reset to commit + force push        |
| `<leader>coo` | n    | Checkout origin branch under cursor |

## Gitsigns (if `kickstart.plugins.gitsigns` loaded)

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

| Key           | Mode | Action                      |
| ------------- | ---- | --------------------------- |
| `<leader>`` ` | n    | Open horizontal terminal    |
| `<leader>`v`  | n    | Open vertical terminal      |
| `<leader>`` ` | t    | Close terminal              |
| `<C-w><C-w>`  | t    | Switch window from terminal |
| `<Esc>`       | t    | Exit to normal mode         |

## Debug (DAP)

| Key          | Mode | Action                     |
| ------------ | ---- | -------------------------- |
| `<F5>`       | n    | Start/continue             |
| `<F1>`       | n    | Step into                  |
| `<F10>`      | n    | Step over                  |
| `<F3>`       | n    | Step out                   |
| `<F8>`       | n    | Stop debugging             |
| `<F7>`       | n    | Toggle DAP UI              |
| `<leader>ba` | n    | Toggle breakpoint          |
| `<leader>Ba` | n    | Set conditional breakpoint |
| `<leader>bt` | n    | Toggle DAP UI              |

## Flash (Navigation)

| Key     | Mode    | Action              |
| ------- | ------- | ------------------- |
| `s`     | n, x, o | Flash jump          |
| `S`     | n, x, o | Flash treesitter    |
| `r`     | o       | Remote flash        |
| `R`     | o, x    | Treesitter search   |
| `<C-s>` | c       | Toggle flash search |

## Multicursor

| Key             | Mode | Action                          |
| --------------- | ---- | ------------------------------- |
| `<C-d>`         | n, x | Add cursor at next match        |
| `<C-q>`         | n, x | Toggle cursor                   |
| `<C-leftmouse>` | n    | Handle mouse click              |
| `<leader>x`     | n, x | Delete cursor (in cursor layer) |
| `<Esc>`         | n, x | Clear cursors (in cursor layer) |

## Emmet

| Key     | Mode | Action              |
| ------- | ---- | ------------------- |
| `<C-A>` | i    | Expand abbreviation |

## Snippets

| Key                 | Mode | Action                        |
| ------------------- | ---- | ----------------------------- |
| `<Tab>` / `<S-Tab>` | i, s | Next/prev snippet placeholder |
| `<C-l>`             | i, s | LuaSnip next choice           |
| `<C-h>`             | i, s | LuaSnip previous choice       |

## Code Runner

| Key          | Mode | Action                                       |
| ------------ | ---- | -------------------------------------------- |
| `<leader>cr` | n    | Compile and run (C++, JS, TS, Python, Shell) |
| `<leader>rb` | n    | npm run build                                |
| `<leader>rd` | n    | npm run dev (in tab)                         |
| `<leader>ri` | n    | npm/yarn/pnpm install                        |
| `<leader>rl` | n    | five-server (live server)                    |

## Code Scaffolding

| Key           | Mode | Action                      |
| ------------- | ---- | --------------------------- |
| `<leader>fnp` | n    | Next.js: new page           |
| `<leader>fnr` | n    | Next.js: new API POST route |
| `<leader>fng` | n    | Next.js: new API GET route  |
| `<leader>fsp` | n    | SvelteKit: new page         |
| `<leader>fsr` | n    | SvelteKit: new POST route   |
| `<leader>fsg` | n    | SvelteKit: new GET route    |

## Code Companion (AI)

| Key          | Mode | Action           |
| ------------ | ---- | ---------------- |
| `<leader>ct` | n    | Open chat        |
| `<leader>cc` | n, v | Inline companion |

## Database

| Key          | Mode | Action       |
| ------------ | ---- | ------------ |
| `<leader>db` | n    | Toggle DB UI |

## Misc

| Key               | Mode    | Action                          |
| ----------------- | ------- | ------------------------------- |
| `<leader>ww`      | n       | Toggle word wrap                |
| `<leader>bo`      | n       | Close hidden buffers            |
| `<leader>rr`      | n       | Reload resource (`:e!`)         |
| `<leader>sel`     | n       | Load session                    |
| `<leader>nq`      | n       | Save session + quit             |
| `<leader>cd`      | n       | cd to current file's directory  |
| `<leader>fc`      | n       | Copy file path to clipboard     |
| `<leader>fe`      | n       | Open Explorer in file folder    |
| `<leader>cpr`     | n       | Competitive programming receive |
| `<leader>cpt`     | n       | Competitive programming test    |
| `<leader>sne`     | n       | Edit snippets                   |
| `<leader>snf`     | n       | Format buffer as snippet string |
| `<leader>snn`     | n       | Show Noice notifications        |
| `<leader>sar`     | n, v    | Search and replace              |
| `<leader>san`     | v       | Search and replace N rows       |
| `<leader>svr`     | v       | Search and visual replace       |
| `<leader>sk`      | v       | Search Kirby (regex replace)    |
| `<leader>rx`      | n       | Install webcomponent types      |
| `<M-n>`           | n       | Open nvim-qt (Android)          |
| `<C-n>` / `<D-n>` | n, i    | Open new Neovide window         |
| `<M-up/down>`     | n       | PageUp / PageDown               |
| `<M-left/right>`  | n, i, x | Word back/forward               |
| `<D-left/right>`  | n, i, x | Home / End                      |
| `<D-up/down>`     | n, i, x | Top / Bottom of file            |
| `>` / `<`         | v       | Indent/dedent (keep visual)     |
| `<BS>`            | v, x    | Black hole delete               |
