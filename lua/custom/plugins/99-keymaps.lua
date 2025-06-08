-- Create a mapping for compiling and running code
vim.api.nvim_set_keymap('n', '<leader>cr', ':lua CompileAndRun()<cr>', {
  noremap = true,
  silent = false,
  desc = '[C]ompile and [R]un',
})

-- emmet
vim.api.nvim_set_keymap('i', '<C-A>', '<Plug>(emmet-expand-abbr)', {
  noremap = true,
  silent = true,
})

-- "Copy Paste from OS Clipboard
vim.keymap.set('v', '<C-v>', '"+p:silent! %s/\\r//g<cr>', {
  desc = '[P]aste from system clipboard',
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<C-v>', '"+p:silent! %s/\\r//g<cr>', {
  desc = '[P]aste from system clipboard',
  noremap = true,
  silent = true,
})
vim.keymap.set('i', '<C-v>', '<esc>"+p:silent! %s/\\r//g<cr>a', {
  desc = '[P]aste from system clipboard',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<S-insert>', '"+p:silent! %s/\\r//g<cr>', {
  desc = '[P]aste from system clipboard',
  noremap = true,
  silent = true,
})
vim.keymap.set('i', '<S-insert>', '<C-r>*<C-o>:silent! %s/\\r//g<cr>', {
  desc = '[P]aste from system clipboard',
  noremap = true,
  silent = true,
})

vim.keymap.set('x', '<C-c>', '"+y', {
  desc = '[Y]ank to system clipboard',
  noremap = true,
  silent = true,
})
vim.keymap.set('x', '<C-insert>', '"+y', {
  desc = '[Y]ank to system clipboard',
  noremap = true,
  silent = true,
})

-- Map Ctrl+S to save
vim.keymap.set('n', '<C-s>', ':w<cr>', {
  desc = '[^s] Save Current File',
  noremap = true,
  silent = true,
})
vim.keymap.set('i', '<C-s>', '<Esc>:w<cr>a', {
  desc = '[^s] Save Current File',
  noremap = true,
  silent = true,
})

-- "Toggle Wrap
vim.keymap.set('n', '<leader>ww', ':set wrap!<CR><CTR>', {
  desc = '[W]ord [W]rap',
  noremap = true,
  silent = true,
})

--
-- "keep visual mode after indent
vim.keymap.set('v', '>', '>gv', {
  desc = '',
  noremap = true,
  silent = true,
})

vim.keymap.set('v', '<', '<gv', {
  desc = '',
  noremap = true,
  silent = true,
})

-- Blackhole Delete with backspace
vim.keymap.set('v', '<BS>', '"_d', {
  desc = 'Black Hole Delete',
  noremap = true,
  silent = true,
})
vim.keymap.set('x', '<BS>', '"_d', {
  desc = 'Black Hole Delete',
  noremap = true,
  silent = true,
})

-- telescope keymap
vim.keymap.set('n', '<leader>?', ':Telescope keymaps<CR>', {
  desc = 'Show Keymaps',
  noremap = true,
  silent = true,
})

-- macos arrow navigation
vim.api.nvim_set_keymap('', '<M-up>', '<PageUp>', {
  noremap = true,
})
vim.api.nvim_set_keymap('', '<M-down>', '<PageDown>', {
  noremap = true,
})

vim.api.nvim_set_keymap('i', '<M-left>', '<c-o>b', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('i', '<M-right>', '<c-o>w', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('x', '<M-left>', 'b', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('x', '<M-right>', 'w', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('n', '<M-left>', 'b', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('n', '<M-right>', 'w', {
  noremap = true,
  silent = false,
})

-- macos, neovide, alacritty terminal
vim.api.nvim_set_keymap('i', '<D-v>', '<esc>"*pa', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('n', '<D-v>', '"*p', {
  noremap = true,
  silent = false,
})

vim.api.nvim_set_keymap('n', '<D-Left>', '<Home>', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('n', '<D-Right>', '<End>', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('i', '<D-Left>', '<Home>', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('i', '<D-Right>', '<End>', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('x', '<D-Left>', '<Home>', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('x', '<D-Right>', '<End>', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('n', '<D-Up>', 'gg', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('n', '<D-Down>', 'G', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('i', '<D-Up>', '<C-o>gg', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('i', '<D-Down>', '<C-o>G', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('x', '<D-Up>', 'gg', {
  noremap = true,
  silent = false,
})
vim.api.nvim_set_keymap('x', '<D-Down>', 'G', {
  noremap = true,
  silent = false,
})

vim.keymap.set('n', '<D-s>', ':w<cr>', {
  desc = '[^s] Save Current File',
  noremap = true,
  silent = true,
})
vim.keymap.set('i', '<D-s>', '<Esc>:w<cr>a', {
  desc = '[^s] Save Current File',
  noremap = true,
  silent = true,
})

-- npm / yarn operation
vim.api.nvim_set_keymap('n', '<leader>rb', ':lua RunCommandAndNotify("npm run build")<CR>', {
  noremap = true,
  silent = false,
  desc = '[R]un [B]uild',
})
vim.api.nvim_set_keymap('n', '<leader>rd', ':lua RunCommandInNewTab("npm run dev")<CR>', {
  noremap = true,
  silent = false,
  desc = '[R]un [D]ev',
})
vim.api.nvim_set_keymap('n', '<leader>ri', ':lua Npm_install()<CR>', {
  noremap = true,
  silent = false,
  desc = '[R]un npm [I]nstall',
})
vim.api.nvim_set_keymap('n', '<leader>rl', ':lua RunCommandInNewTab("five-server")<CR>', {
  noremap = true,
  silent = false,
  desc = '[R]un npm [L]ive Server',
})

-- clear highlight after search by pressing return
vim.api.nvim_set_keymap('n', '<leader>cl', ':noh<CR>:%s/\r//g<CR>', {
  noremap = true,
  silent = true,
  desc = '[C][l]ear Search and NewLine Character',
})

-- cd to current directory
vim.api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', {
  noremap = true,
  silent = false,
  desc = '[C]hange [D]irectory to current file',
})

-- Session
vim.api.nvim_set_keymap('n', '<leader>sel', ":execute 'source ' . fnameescape(expand('~/' . fnamemodify(getcwd(), ':t') . '.vim'))<cr>", {
  noremap = true,
  silent = false,
  desc = '[Se]ssion [L]oad',
})

vim.api.nvim_set_keymap('n', '<leader>nq', ":execute 'mksession! ' . fnameescape(expand('~/' . fnamemodify(getcwd(), ':t') . '.vim'))<cr>:qa!<cr>", {
  noremap = true,
  silent = false,
  desc = '[N]vim [Q]uit',
})

-- vim signature help
vim.api.nvim_set_keymap('n', 'k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>sne', ':EditSnippets<cr>', {
  noremap = true,
  silent = false,
  desc = '[Sn]ippets [E]dit',
})

-- auto format
vim.keymap.set('n', '<leader>fmf', 'gg=G<c-o>', {
  noremap = true,
  silent = false,
  desc = '[F]ormat [M]anual [F]ormat',
})

-- Search and Replace
vim.keymap.set('n', '<leader>sar', ':%s///g<left><left><left>', {
  noremap = true,
  silent = false,
  desc = '[S]earch [A]nd [R]eplace',
})

-- Search and Replace
vim.keymap.set('v', '<leader>sar', '"zy:%s/<c-r>z//g<left><left>', {
  noremap = true,
  silent = false,
  desc = '[S]earch [A]nd [R]eplace',
})

vim.keymap.set('n', '<leader>fnp', ":lua NextJSNewPage(vim.fn.input('Enter Page Name: '))<CR>", {
  noremap = true,
  silent = false,
  desc = 'New [P]age',
})
vim.keymap.set('n', '<leader>fnr', ":lua NextJSNewApiPost(vim.fn.input('Enter Route Name: '))<CR>", {
  noremap = true,
  silent = false,
  desc = 'New Post [R]oute',
})
vim.keymap.set('n', '<leader>fng', ":lua NextJSNewApiGet(vim.fn.input('Enter Route Name: '))<CR>", {
  noremap = true,
  silent = false,
  desc = 'New [G]et Route',
})
vim.keymap.set('n', '<leader>fsp', ":lua SvelteKitNewPage(vim.fn.input('Enter Page Name: '))<CR>", {
  noremap = true,
  silent = false,
  desc = 'New [P]age',
})
vim.keymap.set('n', '<leader>fsr', ":lua SvelteKitNewAPIPost(vim.fn.input('Enter Route Name: '))<CR>", {
  noremap = true,
  silent = false,
  desc = 'New Post [R]oute',
})
vim.keymap.set('n', '<leader>fsg', ":lua SvelteKitNewAPIGet(vim.fn.input('Enter Route Name: '))<CR>", {
  noremap = true,
  silent = false,
  desc = 'New [G]et Route',
})

vim.keymap.set(
  'n',
  '<c-h>',
  ":lua SearchAndReplace(vim.fn.input('Enter Search Term: '),vim.fn.input('Enter Replace Term: '))<CR>",
  -- ":%s/vim.fn.input('Enter Search Term: ')/vim.fn.input('Enter Replace Term: ')/g",
  {
    noremap = true,
    silent = false,
    desc = '[S]earch and [R]eplace',
  }
)

vim.keymap.set('n', '<leader>sg', ':Telescope live_grep<CR>', {
  desc = '[S]earch by [G]rep',
  noremap = true,
  silent = false,
})

vim.keymap.set('n', '<leader>sc', ':lua customSearchGrep()<CR>', {
  desc = '[S]earch by [G]rep [C]ustom',
  noremap = true,
  silent = false,
})

-- close other windows except this one
vim.keymap.set('n', 'x', ':on<cr>', {
  desc = 'Close all other windows',
  noremap = true,
  silent = true,
})

-- Copilot
vim.keymap.set('n', '<leader>ct', ':CopilotChat<cr>', {
  noremap = true,
  silent = false,
  desc = '[C]opilot [C]hat',
})

vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { silent = true, expr = true })

vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { noremap = true, silent = true })

return {}
