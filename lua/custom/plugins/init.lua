--[[ 
  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

  NOTE: SNIPPET/LSP : Trigger with <c-x>. For TM_SELECTED_TEXT, block the text and then <tab>. Move left and right with <c-h> and <c-l>
  NOTE: Copilot : Trigger with <c-d>.

  NOTE: 

  # All
  - pip install pynvim neovim

  # Setup Paste Image: 
  - pip install pillow

  # Setup Jupyter
  - setup conda environment
  - pip install ipykernel jupytext pynvim jupyter_client cairosvg plotly kaleido pyperclip nbformat

  # Install ALL
  - pip install pynvim neovim pillow ipykernel jupytext pynvim jupyter_client cairosvg plotly kaleido pyperclip nbformat
  :UpdateRemotePlugins

  # Windows
  - cp ./rplugin.vim C:\Users\yokow\AppData\Local\nvim-data/rplugin.vim

  # Initialize
  - add environment to molten e.g. labs : python -m ipykernel install --user --name labs --display-name labs
  - initialize jupyter labs : jupyter kernel --kernel=labs


  NOTE: iterm2 setup
  #s -> <C-s>
  !Up -> <M-I> 
  #Up -> <M-i> 
  !Down -> <M-K> 
  #Down -> <M-k> 
  #Left -> <M-j> 
  #Right -> <M-l>

  NOTE: setup lemonade
  > go install github.com/lemonade-command/lemonade@latest
  > ~/go/bin/lemonade server

--]]

-- zz to esc

vim.keymap.set('i', 'zz', '<esc>', { silent = true, desc = 'escape' })
vim.keymap.set('t', 'zz', '<C-\\><C-n>', { desc = '', noremap = true, silent = true })
vim.keymap.set('v', 'zz', '<C-\\><C-n>', { desc = '', noremap = true, silent = true })

-- noswap
vim.o.swapfile = false
vim.o.guifont = 'JetBrainsMono NFM:h13'
vim.o.list = false

-- disable spell for pandoc
vim.api.nvim_set_var('pandoc#spell#enabled', 0)

-- markdown multi table format
vim.g.table_mode_corner_corner = '+'
vim.g.table_mode_header_fillchar = '='

-- markdown bullet and numbering indent
vim.o.breakindentopt = 'list:-1'

sysname = vim.loop.os_uname().sysname
isWindows = sysname == 'Windows_NT'
isMac = sysname == 'Darwin'
isLinux = sysname == 'Linux'

local function fileExists(fileName)
  local file = io.open(fileName, 'r')
  if file then
    file:close()
    return true
  else
    return false
  end
end

-- neovide auto focus
if vim.g.neovide then
  vim.defer_fn(function()
    vim.cmd 'NeovideFocus'
  end, 200)

  if isWindows then
    -- new neovide window in Windows
    vim.keymap.set('n', '<C-n>', ':silent !neovide<cr>', { desc = 'Python', noremap = true, silent = true })
    vim.keymap.set('i', '<C-n>', ':silent !neovide<cr>', { desc = 'Python', noremap = true, silent = true })
  else
    -- new neovide window in MACOS
    vim.keymap.set('n', '<D-n>', ':silent !neovide<cr>', { desc = 'Python', noremap = true, silent = true })
    vim.keymap.set('i', '<D-n>', ':silent !neovide<cr>', { desc = 'Python', noremap = true, silent = true })
  end
else
  -- new nvim-qt window in Android
  vim.keymap.set('n', '<M-n>', ':silent !nvim-qt<cr>', { desc = 'Python', noremap = true, silent = true })
end

if isWindows then
  vim.g.python3_host_prog = 'C:\\Users\\yokow\\miniforge3\\envs\\labs\\python.exe'
end

-- independent clipboard
vim.opt.clipboard = ''

-- set autoindent expandtab tabstop=2 shiftwidth=2
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true

vim.o.foldlevel = 20

function GetFileType()
  local filename = vim.fn.expand '%:t'
  local extension = vim.fn.fnamemodify(filename, ':e')

  if extension == 'js' or extension == 'jsx' then
    return 'javascript'
  elseif extension == 'ts' or extension == 'tsx' then
    return 'typescript'
  elseif extension == 'cpp' or extension == 'c' then
    return 'cpp'
  elseif extension == 'sh' then
    return 'shell'
  else
    return 'unknown'
  end
end

function CompileAndRun()
  local filetype = GetFileType()

  -- Get full folder path of the current buffer
  local folder_path = vim.fn.expand '%:p:h'

  -- get full path up to "labs" folder
  local labs_fullfolder = folder_path:match '(.+labs)'

  -- Get the filename (with extension) of the current buffer
  local filename_with_extension = vim.fn.expand '%:t'

  -- Get the filename without the extension
  local filename_without_extension = vim.fn.expand '%:t:r'

  -- Get the file extension of the current buffer
  local file_extension = vim.fn.fnamemodify(filename_with_extension, ':e')

  if file_extension == 'cjs' or file_extension == 'mjs' then
    filetype = 'javascript'
  elseif file_extension == 'md' then
    filetype = 'markdown'
  end

  local iste = true

  if filetype == 'cpp' then
    vim.cmd(
      ':tabnew | te g++ '
        .. folder_path
        .. '/'
        .. filename_with_extension
        .. ' -o '
        .. folder_path
        .. '/'
        .. filename_without_extension
        .. '.out'
        .. ' && '
        .. folder_path
        .. '/'
        .. filename_without_extension
        .. '.out'
    )
  elseif filetype == 'javascript' then
    vim.cmd(':tabnew | te node ' .. folder_path .. '/' .. filename_with_extension)
  elseif file_extension == 'py' then
    vim.cmd(':tabnew | te python ' .. folder_path .. '/' .. filename_with_extension)
  elseif filetype == 'typescript' then
    vim.cmd(':tabnew | te ts-node ' .. folder_path .. '/' .. filename_with_extension)
  elseif filetype == 'shell' then
    vim.cmd(':tabnew | te bash ' .. folder_path .. '/' .. filename_with_extension)
  elseif filetype == 'markdown' then
    iste = false

    local pandocCommand = 'pandoc -F pandoc-crossref --citeproc '
      .. folder_path
      .. '/'
      .. filename_with_extension
      .. ' -o '
      .. filename_without_extension
      .. '.docx '

    if fileExists 'template.docx' then
      pandocCommand = pandocCommand .. '--reference-doc ./template.docx'
    else
      pandocCommand = pandocCommand .. '--reference-doc ' .. labs_fullfolder .. '/template/base.docx'
    end

    local extractCommand = '7z x ' .. filename_without_extension .. '.docx -o"' .. filename_without_extension .. '"'

    local xmlpath = folder_path .. '/' .. filename_without_extension .. '/word/document.xml'

    local zipCommand = 'rm '
      .. filename_without_extension
      .. '.docx && 7z a -tzip '
      .. filename_without_extension
      .. '.docx ./'
      .. filename_without_extension
      .. '/*'

    local fixCommand = 'sed -i \'s/w:tblStyle w:val="Table"/w:tblStyle w:val="simpletable"/g\' ' .. xmlpath
    fixCommand = fixCommand .. ' && sed -i \'s/w:pStyle w:val="Bibliography"/w:pStyle w:val="DaftarPustaka"/g\' ' .. xmlpath
    fixCommand = fixCommand .. ' && sed -i \'s/w:pStyle w:val="TableCaption"/w:pStyle w:val="figure"/g\' ' .. xmlpath
    fixCommand = fixCommand .. ' && sed -i \'s/w:pStyle w:val="ImageCaption"/w:pStyle w:val="figure"/g\' ' .. xmlpath
    fixCommand = fixCommand .. ' && sed -i \'s/w:pStyle w:val="CaptionedFigure"/w:pStyle w:val="figure"/g\' ' .. xmlpath
    fixCommand = fixCommand
      .. '&& sed -i "s|<w:p><w:pPr><w:pStyle w:val=\\"tableStyle\\" /></w:pPr><w:r><w:t xml:space=\\"preserve\\">'
      .. 'noborder</w:t></w:r></w:p><w:tbl><w:tblPr><w:tblStyle w:val=\\"simpletable\\" />|<w:tbl><w:tblPr>'
      .. '<w:tblStyle w:val=\\"noborder\\" />|g" '
      .. xmlpath

    deleteCommand = 'rm -rf ' .. filename_without_extension

    local refCommand = ''
    -- refCommand = "awk '{while(match($0, /\\#REFTABLE/)) {sub(/\\#REFTABLE/, ++count);} print}'  "
    --   .. filename_without_extension
    --   .. '/word/document.xml > temp.xml && mv temp.xml  '
    --   .. filename_without_extension
    --   .. '/word/document.xml'

    -- print(fixCommand)

    vim.cmd 'cd %:p:h'
    -- vim.cmd('!' .. deleteCommand)
    vim.cmd('!' .. pandocCommand)
    vim.cmd('!' .. extractCommand)
    vim.cmd('!' .. fixCommand)
    vim.cmd('!' .. refCommand)
    vim.cmd('!' .. zipCommand)
    vim.cmd('!' .. deleteCommand)
  else
    vim.notify('Filetype ' .. filetype .. ' not supported for compile and run')
    return
  end

  if iste then
    vim.api.nvim_feedkeys('i', 'n', true)
  end
end

TerminalShell = ''

if isWindows then
  vim.cmd [[command! SaveInitVim :tabnew | exe ':te git -C '. stdpath("config") .' add . & git -C ' . stdpath("config")  . ' commit -m save & git -C ' . stdpath("config")  . ' push']]
  vim.cmd [[command! SaveGlobalSnippets :tabnew | exe ':te git -C '. stdpath("config") .'/../../../git/friendly-snippets add . & git -C '. stdpath("config") .'/../../../git/friendly-snippets commit -m save & git -C '. stdpath("config") .'/../../../git/friendly-snippets push']]
  vim.cmd [[command! LoadGlobalSnippets :tabnew | exe ':te git -C '. stdpath("config") .'/../../../git/friendly-snippets pull']]

  TerminalShell = 'powershell'
else
  vim.cmd [[command! SaveInitVim :tabnew | exe ':te git -C '. stdpath("config") .' add . && git -C ' . stdpath("config")  . ' commit -m save && git -C ' . stdpath("config")  . ' push']]
  vim.cmd [[command! SaveGlobalSnippets :tabnew | exe ':te git -C ~/git/friendly-snippets add . && git -C ~/git/friendly-snippets commit -m save && git -C ~/git/friendly-snippets push']]
  vim.cmd [[command! LoadGlobalSnippets :tabnew | exe ':te git -C ~/git/friendly-snippets pull']]

  TerminalShell = 'bash'
end

-- Create a mapping for compiling and running code
vim.api.nvim_set_keymap('n', '<leader>cr', ':lua CompileAndRun()<cr>', { noremap = true, silent = false, desc = '[C]ompile and [R]un' })

-- Enable line numbers (both absolute and relative)
vim.wo.relativenumber = true

-- "Keep it Centered
-- Create nnoremap mappings
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true, silent = true })
vim.o.hlsearch = true

-- emmet
vim.api.nvim_set_keymap('i', '<C-A>', '<Plug>(emmet-expand-abbr)', { noremap = true, silent = true })

-- "Copy Paste from OS Clipboard
vim.keymap.set('v', '<C-v>', '"+p:silent! %s/\\r//g<cr>', { desc = '[P]aste from system clipboard', noremap = true, silent = true })
vim.keymap.set('n', '<C-v>', '"+p:silent! %s/\\r//g<cr>', { desc = '[P]aste from system clipboard', noremap = true, silent = true })
vim.keymap.set('i', '<C-v>', '<esc>"+p:silent! %s/\\r//g<cr>a', { desc = '[P]aste from system clipboard', noremap = true, silent = true })

vim.keymap.set('n', '<S-insert>', '"+p:silent! %s/\\r//g<cr>', { desc = '[P]aste from system clipboard', noremap = true, silent = true })
vim.keymap.set('i', '<S-insert>', '<C-r>*<C-o>:silent! %s/\\r//g<cr>', { desc = '[P]aste from system clipboard', noremap = true, silent = true })

vim.keymap.set('x', '<C-c>', '"+y', { desc = '[Y]ank to system clipboard', noremap = true, silent = true })
vim.keymap.set('x', '<C-insert>', '"+y', { desc = '[Y]ank to system clipboard', noremap = true, silent = true })

-- "Database Toggle UI"
vim.keymap.set('n', '<leader>db', ':DBUIToggle<cr>', { desc = '[D]ata[b]ase', noremap = true, silent = true })

-- Map Ctrl+S to save
vim.keymap.set('n', '<C-s>', ':w<cr>', { desc = '[^s] Save Current File', noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<cr>a', { desc = '[^s] Save Current File', noremap = true, silent = true })

-- "Tab Navigation
vim.keymap.set('n', '<leader><up>', ':tabnew<CR>', { desc = 'New Tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader><right>', ':tabnext<CR>', { desc = 'Next Tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader><left>', ':tabprevious<CR>', { desc = 'Previous Tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader><down>', ':tabclose<CR>', { desc = 'Close Tab', noremap = true, silent = true })

-- nerdtree
vim.keymap.set('n', '<c-z>', ':NvimTreeToggle<cr>', { desc = 'Show File Explorer', noremap = true, silent = true })
vim.keymap.set('i', '<c-z>', ':NvimTreeToggle<cr>', { desc = 'Show File Explorer', noremap = true, silent = true })

-- "Toggle Wrap
vim.keymap.set('n', '<leader>ww', ':set wrap!<CR><CTR>', { desc = '[W]ord [W]rap', noremap = true, silent = true })

-- "TERMINAL
vim.keymap.set(
  'n',
  '<leader>``',
  ':horizontal terminal ' .. TerminalShell .. '<CR><C-w>J<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-',
  { desc = 'Open Terminal', noremap = false, silent = true }
)
vim.keymap.set('n', '<leader>`v', '<C-w>v:terminal ' .. TerminalShell .. '<CR>', { desc = 'Open Terminal [V]ertical', noremap = false, silent = true })
vim.keymap.set('t', '<leader>`', '<C-\\><C-n>:q<CR>', { desc = '', noremap = true, silent = true })
vim.keymap.set('t', '<C-w><C-w>', '<C-\\><C-n><C-w><C-w>', { desc = '', noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = '', noremap = true, silent = true })

-- "RESIZE WINDOW
vim.keymap.set('n', '.', ':vertical resize -10<cr>', { desc = '', noremap = true, silent = true })
vim.keymap.set('n', ',', ':vertical resize +5<CR>', { desc = '', noremap = true, silent = true })
vim.keymap.set('n', "'", ':horizontal resize -5<CR>', { desc = '', noremap = true, silent = true })
vim.keymap.set('n', ';', ':horizontal resize +2<CR>', { desc = '', noremap = true, silent = true })
--
-- "keep visual mode after indent
vim.keymap.set('v', '>', '>gv', { desc = '', noremap = true, silent = true })
vim.keymap.set('v', '<', '<gv', { desc = '', noremap = true, silent = true })

-- Blackhole Delete with backspace
vim.keymap.set('v', '<BS>', '"_d', { desc = 'Black Hole Delete', noremap = true, silent = true })
vim.keymap.set('x', '<BS>', '"_d', { desc = 'Black Hole Delete', noremap = true, silent = true })

-- telescope keymap
vim.keymap.set('n', '<leader>?', ':Telescope keymaps<CR>', { desc = 'Show Keymaps', noremap = true, silent = true })

-- "Git Mapping
function GitPullAndNotify()
  vim.notify('Pull Processing...', vim.log.levels.INFO, {
    title = 'Git',
    timeout = 36000000,
  })

  vim.fn.jobstart('git pull', {
    on_stdout = function(id, data, e)
      notif(id, data, e, 4000)
    end,
    on_stderr = function(id, data, e)
      notif(id, data, e, 4000)
    end,
    on_exit = function(id, data, e)
      notif(id, data, e, 4000)
    end,
  })
end

function BuildAndNotify()
  vim.notify('Building Project...', vim.log.levels.INFO, {
    title = 'NPM',
    timeout = 36000000,
  })

  vim.fn.jobstart('npm run build', {
    on_stdout = function(id, data, e)
      notif(id, data, e, 4000)
    end,
    on_stderr = function(id, data, e)
      notif(id, data, e, 4000)
    end,
    on_exit = function(id, data, e)
      notif(id, data, e, 4000)
    end,
  })
end

function RunCommandInNewTab(command)
  vim.cmd(':tabnew | te  ' .. command)
end

function RunCommandAndNotify(command, timeout, title)
  if timeout == nil then
    timeout = 36000000
  end
  if title == nil then
    title = 'Run Command'
  end
  vim.notify(title, vim.log.levels.INFO, {
    title = title,
    timeout = timeout,
  })

  vim.fn.jobstart(command, {
    on_stdout = function(id, data, e)
      notif(id, data, e, 4000)
    end,
    on_stderr = function(id, data, e)
      notif(id, data, e, 4000)
    end,
    on_exit = function(id, data, e)
      notif(id, data, e, 4000)
    end,
  })
end

function GitPushAndNotify()
  vim.notify('Push Processing...', vim.log.levels.INFO, {
    title = 'Git',
    timeout = 36000000,
  })

  vim.fn.jobstart('git push', {
    on_stdout = function(id, data, e)
      notif(id, data, e, 4000)
    end,
    on_stderr = function(id, data, e)
      notif(id, data, e, 4000)
    end,
    on_exit = function(id, data, e)
      notif(id, data, e, 4000)
    end,
  })
end

function OpenGitStatus()
  local windows = vim.api.nvim_list_wins()
  for _, v in pairs(windows) do
    local status, _ = pcall(vim.api.nvim_win_get_var, v, 'fugitive_status')
    if status then
      vim.api.nvim_win_close(v, false)
      return
    end
  end
  vim.cmd [[NvimTreeClose | vertical Git]]
  vim.cmd [[vertical resize -30]]
  vim.cmd [[wincmd H]]
end

vim.keymap.set('n', '<c-q>', [[:lua OpenGitStatus()<cr>]], { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gs', [[:lua OpenGitStatus()<cr>]], { desc = '[G]it [S]tatus' })

function GitCommit(commitMessage)
  RunCommandAndNotify('git add . && git commit -m "' .. commitMessage .. '"')
end

vim.keymap.set('n', '<leader>gc', function()
  local commitMessage = vim.fn.input 'Enter commit message: '
  if commitMessage == '' then
    return
  end

  GitCommit(commitMessage)
end, { desc = '[G]it [C]ommit', noremap = true, silent = false })

vim.keymap.set('n', '<leader>gp', [[:lua GitPushAndNotify()<CR>]], { desc = '[G]it [P]ush', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gu', [[:lua GitPullAndNotify()<CR>]], { desc = '[G]it P[u]ll', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gd', ':vertical Git diff<CR>', { desc = '[G]it [D]iff', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gv', ':Gvdiffsplit<CR>', { desc = '[G]it [V]ertical Diff Current File', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gl', ':vertical Git log<CR>', { desc = '[G]it [L]og', noremap = true, silent = true })

-- Toggle Spectre
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = 'Toggle Spectre. Search and Replace text in multiple files',
})

-- copilot asdasd
vim.api.nvim_set_keymap('n', '<leader>cp', ':Copilot panel<cr>', { noremap = true, silent = false, desc = '[C]opilot [P]anel' })

-- save Cursor
vim.cmd [[
  autocmd BufReadPost *
        \ if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' &&
        \ line("'\"") > 1 &&
        \ line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
]]

-- macos arrow navigation
vim.api.nvim_set_keymap('', '<M-up>', '<PageUp>', { noremap = true })
vim.api.nvim_set_keymap('', '<M-down>', '<PageDown>', { noremap = true })

vim.api.nvim_set_keymap('i', '<M-left>', '<c-o>b', { noremap = true, silent = false })
vim.api.nvim_set_keymap('i', '<M-right>', '<c-o>w', { noremap = true, silent = false })
vim.api.nvim_set_keymap('x', '<M-left>', 'b', { noremap = true, silent = false })
vim.api.nvim_set_keymap('x', '<M-right>', 'w', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-left>', 'b', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<M-right>', 'w', { noremap = true, silent = false })

-- macos, neovide, alacritty terminal
vim.api.nvim_set_keymap('i', '<D-v>', '<esc>"*pa', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<D-v>', '"*p', { noremap = true, silent = false })

vim.api.nvim_set_keymap('n', '<D-Left>', '<Home>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<D-Right>', '<End>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('i', '<D-Left>', '<Home>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('i', '<D-Right>', '<End>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('x', '<D-Left>', '<Home>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('x', '<D-Right>', '<End>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<D-Up>', 'gg', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<D-Down>', 'G', { noremap = true, silent = false })
vim.api.nvim_set_keymap('i', '<D-Up>', '<C-o>gg', { noremap = true, silent = false })
vim.api.nvim_set_keymap('i', '<D-Down>', '<C-o>G', { noremap = true, silent = false })
vim.api.nvim_set_keymap('x', '<D-Up>', 'gg', { noremap = true, silent = false })
vim.api.nvim_set_keymap('x', '<D-Down>', 'G', { noremap = true, silent = false })

vim.keymap.set('n', '<D-s>', ':w<cr>', { desc = '[^s] Save Current File', noremap = true, silent = true })
vim.keymap.set('i', '<D-s>', '<Esc>:w<cr>a', { desc = '[^s] Save Current File', noremap = true, silent = true })

-- npm / yarn operation
vim.api.nvim_set_keymap('n', '<leader>rb', ':lua RunCommandAndNotify("npm run build")<CR>', { noremap = true, silent = false, desc = '[R]un [B]uild' })
vim.api.nvim_set_keymap('n', '<leader>rd', ':lua RunCommandInNewTab("npm run dev")<CR>', { noremap = true, silent = false, desc = '[R]un [D]ev' })
vim.api.nvim_set_keymap('n', '<leader>ri', ':lua Npm_install()<CR>', { noremap = true, silent = false, desc = '[R]un npm [I]nstall' })

-- clear highlight after search by pressing return
vim.api.nvim_set_keymap('n', '<leader>cl', ':noh<CR>:%s/\r//g<CR>', { noremap = true, silent = true, desc = '[C][l]ear Search and NewLine Character' })

-- cd to current directory
vim.api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { noremap = true, silent = false, desc = '[C]hange [D]irectory to current file' })

-- NPM
function Npm_install()
  local package_lock_exists = vim.fn.filereadable 'package-lock.json' == 1
  local yarn_lock_exists = vim.fn.filereadable 'yarn.lock' == 1
  local pnpm_lock_exists = vim.fn.filereadable 'pnpm-lock.yaml' == 1
  if package_lock_exists then
    RunCommandInNewTab 'npm install --legacy-peer-deps'
  elseif yarn_lock_exists then
    RunCommandInNewTab 'yarn'
  elseif pnpm_lock_exists then
    RunCommandInNewTab 'pnpm install'
  else
    RunCommandInNewTab 'npm install --legacy-peer-deps'
  end
end

-- Session
vim.api.nvim_set_keymap('n', '<leader>sel', ':source ~/session.vim<cr>', { noremap = true, silent = false, desc = '[Se]ssion [L]oad' })
vim.api.nvim_set_keymap('n', '<leader>ses', ':mksession! ~/session.vim<cr>', { noremap = true, silent = false, desc = '[Se]ssion [S]ave' })
vim.api.nvim_set_keymap('n', '<leader>nq', ':mksession! ~/session.vim<cr>:qa!<cr>', { noremap = true, silent = false, desc = '[N]vim [Q]uit' })

-- vim signature help
vim.api.nvim_set_keymap('n', 'k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })

function InsertConsoleLog()
  local line_number = vim.fn.line '.'
  local current_file = '🚀 : ' .. vim.fn.expand '%:t'
  local log_statement = string.format("console.log('%s:%d');", current_file, line_number + 1)
  vim.fn.append(line_number, log_statement)
end

vim.api.nvim_set_keymap('n', '<Leader>lg', [[:lua InsertConsoleLog()<CR>]], { noremap = true, silent = true, desc = 'console.log file and line' })

vim.cmd [[command! EditBaseVim :tabnew | exe 'edit '. stdpath('config').'/init.lua']]
vim.cmd [[command! EditInitVim :tabnew | exe 'edit '. stdpath('config').'/lua/custom/plugins/init.lua']]
vim.cmd [[command! EditFSVim :tabnew | exe 'edit '. stdpath('config').'/lua/custom/plugins/fs.lua']]
vim.cmd [[command! LoadInitVim :tabnew | exe ':te git -C '. stdpath("config") .' pull' ]]
vim.cmd [[command! EditSnippets :lua require("luasnip.loaders").edit_snippet_files()]]

vim.o.encoding = 'utf-8'

-- jupyter
vim.keymap.set('n', '<leader>ji', ':MoltenInit<cr>', { noremap = true, silent = false, desc = '[J]upyter [I]nnit' })
vim.keymap.set('n', '<leader>jr', '/```<cr><up>VN<down>:<C-u>MoltenEvaluateVisual<CR>``:noh<cr>', { noremap = true, silent = false, desc = '[J]upyter [R]un' })
vim.keymap.set('n', '<leader>jo', ':noautocmd MoltenEnterOutput<CR>', { noremap = true, silent = false, desc = '[J]upyter Enter [O]utput' })
vim.keymap.set('n', '<leader>jh', ':MoltenHideOutput<CR>', { noremap = true, silent = false, desc = '[J]upyter [H]ide Output' })

-- auto format
vim.keymap.set('n', '<leader>fmf', 'gg=G<c-o>', { noremap = true, silent = false, desc = '[F]ormat [M]anual [F]ormat' })

-- Search and Replace
vim.keymap.set('n', '<leader>sar', ':%s///g<left><left><left>', { noremap = true, silent = false, desc = '[S]earch [A]nd [R]eplace' })

function NextJSNewPage(pagename)
  local page_path = 'src/app/pages/' .. pagename .. '/page.tsx'
  local page_content = {}
  page_content[#page_content + 1] = [["use client"]]
  page_content[#page_content + 1] = [[import type { NextPage } from "next";]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[const Test: NextPage<{ someProps: string }> = (props) => {]]
  page_content[#page_content + 1] = [[  return <>Hello Test</>;]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export default Test;]]
  vim.fn.mkdir('src/app/pages/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

function NextJSNewApiGet(pagename)
  local page_path = 'src/app/api/' .. pagename .. '/route.ts'
  local page_content = {}
  page_content[#page_content + 1] = [[import { NextRequest, NextResponse } from "next/server";]]
  page_content[#page_content + 1] = [[// export const runtime = "edge";]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const OPTIONS = async () => {]]
  page_content[#page_content + 1] = [[  return NextResponse.json({]]
  page_content[#page_content + 1] = [[    status: "ok",]]
  page_content[#page_content + 1] = [[  });]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const GET = async (]]
  page_content[#page_content + 1] = [[  req: NextRequest,]]
  page_content[#page_content + 1] = [[  { params }: { params: { [s: string]: string } }]]
  page_content[#page_content + 1] = [[) => {]]
  page_content[#page_content + 1] = [[  try {]]
  page_content[#page_content + 1] = [[    const url = new URL(req.url);]]
  page_content[#page_content + 1] = [[    const {} = params ? params : {};]]
  page_content[#page_content + 1] = [[    const searchParams = new URLSearchParams(url.search);]]
  page_content[#page_content + 1] = [[    const test = searchParams.get("test");]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[    return NextResponse.json({ status: "ok", test });]]
  page_content[#page_content + 1] = [[  } catch (error) {]]
  page_content[#page_content + 1] = [[    return NextResponse.json({ err: (error as any).toString() });]]
  page_content[#page_content + 1] = [[  }]]
  page_content[#page_content + 1] = [[};]]
  vim.fn.mkdir('src/app/api/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

function NextJSNewApiPost(pagename)
  local page_path = 'src/app/api/' .. pagename .. '/route.ts'
  local page_content = {}
  page_content[#page_content + 1] = [[import { NextRequest, NextResponse } from "next/server";]]
  page_content[#page_content + 1] = [[// export const runtime = "edge";]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const OPTIONS = async () => {]]
  page_content[#page_content + 1] = [[  return NextResponse.json({]]
  page_content[#page_content + 1] = [[    status: "ok",]]
  page_content[#page_content + 1] = [[  });]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const POST = async (]]
  page_content[#page_content + 1] = [[  req: NextRequest,]]
  page_content[#page_content + 1] = [[  { params }: { params: { [s: string]: string } }]]
  page_content[#page_content + 1] = [[) => {]]
  page_content[#page_content + 1] = [[  try {]]
  page_content[#page_content + 1] = [[    const body = await req.json();]]
  page_content[#page_content + 1] = [[    const {}: { [key: string]: string } = body;]]
  page_content[#page_content + 1] = [[    const {} = params;]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[    return NextResponse.json({ status: "ok", body });]]
  page_content[#page_content + 1] = [[  } catch (error) {]]
  page_content[#page_content + 1] = [[    return NextResponse.json({ err: (error as any).toString() });]]
  page_content[#page_content + 1] = [[  }]]
  page_content[#page_content + 1] = [[};]]
  vim.fn.mkdir('src/app/api/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

function SvelteKitNewPage(pagename)
  local page_path = 'src/routes/' .. pagename .. '/+page.svelte'
  local page_content = {}
  vim.fn.mkdir('src/routes/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

function SvelteKitNewAPIPost(pagename)
  local page_path = 'src/routes/api/' .. pagename .. '/+server.ts'
  local page_content = {}
  page_content[#page_content + 1] = [[import { json } from "@sveltejs/kit";]]
  page_content[#page_content + 1] = [[import type { RequestHandler } from "./$types";]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[const headers = {]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Origin": "*",]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Methods": "GET,HEAD,PUT,PATCH,POST,DELETE",]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Headers": "Content-Type,authorization",]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const OPTIONS: RequestHandler = () => {]]
  page_content[#page_content + 1] = [[  return new Response("", {]]
  page_content[#page_content + 1] = [[    status: 200,]]
  page_content[#page_content + 1] = [[    headers,]]
  page_content[#page_content + 1] = [[  });]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[export const POST: RequestHandler = async ({ request, cookies }) => {]]
  page_content[#page_content + 1] = [[  const { something } = await request.json();]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[  return json({ something }, { status: 200, headers });]]
  page_content[#page_content + 1] = [[};]]
  vim.fn.mkdir('src/routes/api/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

function SvelteKitNewAPIGet(pagename)
  local page_path = 'src/routes/api/' .. pagename .. '/+server.ts'
  local page_content = {}
  page_content[#page_content + 1] = [[import { json } from "@sveltejs/kit";]]
  page_content[#page_content + 1] = [[import type { RequestHandler } from "./$types";]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[const headers = {]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Origin": "*",]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Methods": "GET,HEAD,PUT,PATCH,POST,DELETE",]]
  page_content[#page_content + 1] = [[  "Access-Control-Allow-Headers": "Content-Type,authorization",]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const OPTIONS: RequestHandler = () => {]]
  page_content[#page_content + 1] = [[  return new Response("", {]]
  page_content[#page_content + 1] = [[    status: 200,]]
  page_content[#page_content + 1] = [[    headers,]]
  page_content[#page_content + 1] = [[  });]]
  page_content[#page_content + 1] = [[};]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[export const GET: RequestHandler = ({ url, params }) => {]]
  page_content[#page_content + 1] = [[  const q = url.searchParams.get("q");]]
  page_content[#page_content + 1] = [[  // const slug = params.slug;]]
  page_content[#page_content + 1] = [[  const number = Math.floor(Math.random() * 6) + 1;]]
  page_content[#page_content + 1] = [[]]
  page_content[#page_content + 1] = [[  return json({ number }, {status:200, headers});]]
  page_content[#page_content + 1] = [[};]]
  vim.fn.mkdir('src/routes/api/' .. pagename, 'p')
  vim.fn.writefile(page_content, page_path)
  vim.cmd('e ' .. page_path)
end

vim.keymap.set('n', '<leader>fnp', ":lua NextJSNewPage(vim.fn.input('Enter Page Name: '))<CR>", { noremap = true, silent = false, desc = 'New [P]age' })
vim.keymap.set(
  'n',
  '<leader>fnr',
  ":lua NextJSNewApiPost(vim.fn.input('Enter Route Name: '))<CR>",
  { noremap = true, silent = false, desc = 'New Post [R]oute' }
)
vim.keymap.set('n', '<leader>fng', ":lua NextJSNewApiGet(vim.fn.input('Enter Route Name: '))<CR>", { noremap = true, silent = false, desc = 'New [G]et Route' })
vim.keymap.set('n', '<leader>fsp', ":lua SvelteKitNewPage(vim.fn.input('Enter Page Name: '))<CR>", { noremap = true, silent = false, desc = 'New [P]age' })
vim.keymap.set(
  'n',
  '<leader>fsr',
  ":lua SvelteKitNewAPIPost(vim.fn.input('Enter Route Name: '))<CR>",
  { noremap = true, silent = false, desc = 'New Post [R]oute' }
)
vim.keymap.set(
  'n',
  '<leader>fsg',
  ":lua SvelteKitNewAPIGet(vim.fn.input('Enter Route Name: '))<CR>",
  { noremap = true, silent = false, desc = 'New [G]et Route' }
)

function SearchAndReplace(search, replace)
  -- make sure search is not empty
  if search == '' then
    return
  end

  local command = ':%s/' .. search .. '/' .. replace .. '/g'
  local termcodes = vim.api.nvim_replace_termcodes(command, true, true, true)
  vim.api.nvim_feedkeys(termcodes, 'n', true)
end

vim.keymap.set(
  'n',
  '<c-h>',
  ":lua SearchAndReplace(vim.fn.input('Enter Search Term: '),vim.fn.input('Enter Replace Term: '))<CR>",
  -- ":%s/vim.fn.input('Enter Search Term: ')/vim.fn.input('Enter Replace Term: ')/g",
  { noremap = true, silent = false, desc = '[S]earch and [R]eplace' }
)

-- livegrep search
function customSearchGrep()
  local extension = vim.fn.input 'Enter File Extension (*): '
  local dirs = vim.fn.input 'Enter Search Directories (.): '

  -- if escape is pressed, return
  if extension == '' and dirs == '' then
    return
  end

  if extension == '' then
    extension = '*'
  end
  if dirs == '' then
    dirs = '.'
  end

  vim.cmd('Telescope live_grep glob_pattern=*.{' .. extension .. '} search_dirs=' .. dirs)
end

vim.keymap.set('n', '<leader>sg', ':Telescope live_grep<CR>', { desc = '[S]earch by [G]rep', noremap = true, silent = false })

vim.keymap.set('n', '<leader>sc', ':lua customSearchGrep()<CR>', { desc = '[S]earch by [G]rep [C]ustom', noremap = true, silent = false })

-- bookmarks <leader>b
vim.keymap.set('n', '<leader>b1', ':e ~/git/react-mandiri<cr>', { desc = '[B] 1. React Mandiri', noremap = true, silent = false })
vim.keymap.set('n', '<leader>b2', ':e ~/git/svelte-cbtadmin/<cr>', { desc = '[B] 2. Svelte CBTAdmin', noremap = true, silent = false })
vim.keymap.set('n', '<leader>b3', ':e ~/git/cbt-semioffline-nextjs/<cr>', { desc = '[B] 3. CBT Semioffline Nextjs', noremap = true, silent = false })
vim.keymap.set('n', '<leader>b4', ':e ~/git/couch-cbt/<cr>', { desc = '[B] 4. Couch CBT', noremap = true, silent = false })
vim.keymap.set('n', '<leader>b5', ':e ~/git/resta/<cr>', { desc = '[B] 5. Resta Cloudflare and Bunny Domain Register', noremap = true, silent = false })
vim.keymap.set('n', '<leader>b6', ':e ~/git/cbtadmin/<cr>', { desc = '[B] 6. CBTAdmin Cloudflare Workers ', noremap = true, silent = false })
vim.keymap.set('n', '<leader>b7', ':e ~/git/labs<cr>', { desc = '[B] 7. LABS ', noremap = true, silent = false })
vim.keymap.set('n', '<leader>b8', ':e ~/git/wiki-bimasoft<cr>', { desc = '[B] 8. Wiki Bimasoft ', noremap = true, silent = false })
vim.keymap.set('n', '<leader>b9', ':e ~/git/labs/kuliah/s2/beasiswa/paper/paper.md<cr>', { desc = '[B] 9. Paper Beasiswa ', noremap = true, silent = false })
vim.keymap.set('n', '<leader>ba0', ':e ~/git/adminlte/<cr>', { desc = 'MMS (AdminLTE)', noremap = true, silent = false })
vim.keymap.set('n', '<leader>ba1', ':e d:/xampp/htdocs/adminlte/<cr>', { desc = 'MMS (AdminLTE d:\\xampp\\)', noremap = true, silent = false })
vim.keymap.set('n', '<leader>ba2', ':e ~/git/client.bimasoft.web.id/<cr>', { desc = 'client area', noremap = true, silent = false })
vim.keymap.set('n', '<leader>bai', ':EditInitVim<cr>', { desc = 'Init Vim', noremap = true, silent = false })
vim.keymap.set('n', '<leader>bab', ':EditBaseVim<cr>', { desc = 'Base Vim', noremap = true, silent = false })

-- change language
vim.keymap.set('n', '<leader>lcj', ':set ft=javascript<cr>', { desc = 'Javascript', noremap = true, silent = false })
vim.keymap.set('n', '<leader>lco', ':set ft=json<cr>', { desc = 'JSON', noremap = true, silent = false })
vim.keymap.set('n', '<leader>lcp', ':set ft=php<cr>', { desc = 'PHP', noremap = true, silent = false })
vim.keymap.set('n', '<leader>lcy', ':set ft=python<cr>', { desc = 'Python', noremap = true, silent = false })

-- nvimtree setup
local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 't', api.node.open.tab, opts 'Open: New Tab')
  vim.keymap.set('n', 'v', api.node.open.vertical, opts 'Open: Vertical Split')
  vim.keymap.set('n', 'x', api.node.open.horizontal, opts 'Open: Horizontal Split')
  vim.keymap.set('n', 'm', api.fs.rename_full, opts 'Rename: Full Path')
end

vim.keymap.set('n', '<leader>pi', ':Pastify<cr>', { desc = '[P]aste [I]mage', noremap = true, silent = false })

local ls = require 'luasnip'
ls.config.set_config {
  store_selection_keys = '<tab>',
}

require('nvim-treesitter.install').compilers = { 'clang', 'gcc', 'zig' }

require('which-key').add {
  {
    { "'", hidden = true },
    { '<leader>b', group = '[B]ookmarks' },
    { '<leader>c', group = '[C]hat' },
    { '<leader>cg', group = '[C]hat a[G]ent' },
    { '<leader>d', group = '[D]atabase' },
    { '<leader>f', group = '[F]ormat/[F]ramework' },
    { '<leader>fn', group = '[F]ramework [N]extJS' },
    { '<leader>fs', group = '[F]ramework [S]velte' },
    { '<leader>g', group = '[G]it' },
    { '<leader>j', group = '[J]upyter' },
    { '<leader>l', group = '[L]anguage / [L]og' },
    { '<leader>lc', group = '[L]anguage [C]hange' },
    { '<leader>n', group = '[N]eovim' },
    { '<leader>p', group = '[P]aste' },
  },
}

require('mini.surround').setup {
  mappings = {
    add = 'ra', -- Add surrounding in Normal and Visual modes
    delete = 'rd', -- Delete surrounding
    find = 'rf', -- Find surrounding (to the right)
    find_left = 'rF', -- Find surrounding (to the left)
    highlight = 'rh', -- Highlight surrounding
    replace = 'rr', -- Replace surrounding
    update_n_lines = 'rn', -- Update `n_lines`
  },
}

-- close window with x if it's not a main window
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'checkhealth',
    'fugitive*',
    'git',
    'help',
    'lspinfo',
    'netrw',
    'notify',
    'qf',
    'query',
  },
  callback = function()
    vim.keymap.set('n', 'x', vim.cmd.close, { desc = 'Close the current buffer', buffer = true })
  end,
})

-- close other windows except this one
vim.keymap.set('n', 'x', ':on<cr>', { desc = 'Close all other windows', noremap = true, silent = true })

chatagent = 'chatgpt'
-- code companion
vim.keymap.set('n', '<leader>cgc', function()
  chatagent = 'chatgpt'
  vim.notify 'Chat Agent : chatgpt 3.5 turbo'
end, { desc = 'ChatGPT', noremap = true, silent = false })

vim.keymap.set('n', '<leader>cgh', function()
  chatagent = 'haiku'
  vim.notify 'Chat Agent : Claude 3 Haiku'
end, { desc = 'Claude Haiku', noremap = true, silent = false })

vim.keymap.set('n', '<leader>cgo', function()
  chatagent = 'opus'
  vim.notify 'Chat Agent : Claude 3 Opus'
end, { desc = 'Claude Opus', noremap = true, silent = false })

vim.keymap.set('n', '<leader>cgs', function()
  chatagent = 'sonet'
  vim.notify 'Chat Agent : Claude 3.5 Sonet'
end, { desc = 'Claude Sonet', noremap = true, silent = false })

vim.keymap.set('n', '<leader>ct', function()
  vim.cmd('CodeCompanionChat ' .. chatagent)
end, { noremap = true, silent = false, desc = 'New [C]hat AI Bo[t]' })

vim.keymap.set('n', '<leader>cc', function()
  vim.cmd 'CodeCompanion'
end, { noremap = true, silent = false, desc = '[C]ode [C]ompanion' })

vim.g.markdown_fenced_languages = { 'html', 'python', 'lua', 'vim', 'typescript', 'javascript' }

require('luasnip.loaders.from_vscode').lazy_load { paths = { '~/git/friendly-snippets' } }

return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- Optional
      {
        'stevearc/dressing.nvim', -- Optional: Improves the default Neovim UI
        opts = {},
      },
    },
    config = function()
      require('codecompanion').setup {
        strategies = {
          chat = { adapter = 'chatgpt' },
          inline = { adapter = 'chatgpt' },
          tool = { adapter = 'opus' },
        },
        adapters = {
          sonet = require('codecompanion.adapters').extend('anthropic', {
            schema = {
              model = {
                default = 'claude-3-5-sonnet-20240620',
              },
              max_tokens = {
                default = 8192,
              },
            },
          }),
          opus = require('codecompanion.adapters').extend('anthropic', {
            schema = {
              model = {
                default = 'claude-3-opus-20240229',
              },
            },
          }),
          haiku = require('codecompanion.adapters').extend('anthropic', {
            schema = {
              model = {
                default = 'claude-3-haiku-20240307',
              },
              max_tokens = {
                default = 4096,
              },
            },
          }),
          chatgpt = require('codecompanion.adapters').extend('openai', {
            schema = {
              model = {
                default = 'gpt-4o-mini',
              },
              max_tokens = {
                default = 16384,
              },
            },
          }),
        },
      }
    end,
  },
  {
    'm4xshen/autoclose.nvim',
    config = function()
      require('autoclose').setup()
    end,
  },
  {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    config = function()
      require('chatgpt').setup()
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        search = { enabled = false },
      },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "o", "x" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    'rcarriga/nvim-notify',
    config = function() -- This is the function that runs, AFTER loading
      -- Notification Setup
      require('notify').setup {
        stages = 'static',
      }
      vim.notify = require 'notify'
      function notif(jobid, data, event, timeout, notifid)
        local output = table.concat(data, '\n')
        if output == '' then
        else
          vim.notify.dismiss()
          vim.notify(output, vim.log.levels.WARN, {
            title = 'Notification',
            timeout = timeout,
          })
        end
      end
    end,
  },
  'nvim-pack/nvim-spectre',
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        update_focused_file = {
          enable = true,
        },
        git = {
          enable = false,
        },
        sort = {
          sorter = 'case_sensitive',
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        on_attach = my_on_attach,
        filters = {
          dotfiles = false,
        },
      }
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-treesitter.configs').setup {
        sync_install = false,
        ensure_installed = '',
        ignore_install = {},
        auto_install = false,
        modules = {},
        autotag = {
          enable = true,
        },
      }
    end,
  },
  'mattn/emmet-vim',
  'tpope/vim-fugitive',
  {
    'gaelph/logsitter.nvim',
    config = function()
      vim.keymap.set('n', '<leader>lg', function()
        require('logsitter').log()
      end)
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>ff',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_after_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        pandoc = { 'prettierd' },
        markdown = { 'prettierd' },
        json = { 'prettierd' },
        css = { 'prettierd' },
        yml = { 'prettierd' },
        html = { 'prettierd' },
        php = { 'pretty-php' },
        cpp = { 'clang_format' },
        -- javascript = { { 'prettierd', 'prettier' } },
      },
      formatters = {
        ['php-cs-fixer'] = {
          command = 'php-cs-fixer',
          args = {
            'fix',
            '$FILENAME',
          },
          stdin = false,
        },
        ['djlint'] = {
          prepend_args = { '--indent', '2' },
        },
        ['pretty-php'] = {
          prepend_args = { '-s2' },
        },
      },
    },
  },
  {
    'yokowasis/multicursors.nvim',
    event = 'VeryLazy',
    dependencies = {
      'yokowasis/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' },
        '<Leader>m',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selected text or word under the cursor',
      },
    },
  },
  {
    'yokowasis/vim-table-mode',
  },
  {
    'axelvc/template-string.nvim',
    config = function()
      require('template-string').setup()
    end,
  },
  {
    'TobinPalmer/pastify.nvim',
    cmd = { 'Pastify' },
    config = function()
      require('pastify').setup {
        opts = {
          save = 'local',
        },
      }
    end,
  },
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        -- optional configuration here
        code_style = {
          comments = { italic = true },
          conditionals = { italic = true },
          keywords = {},
          functions = {},
          namespaces = { italic = true },
          parameters = { italic = true },
          strings = {},
          variables = {},
        },
      }
      require('bamboo').load()
    end,
  },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {}
    end,
  },
}
