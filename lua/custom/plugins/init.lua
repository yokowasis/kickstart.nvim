-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- noswap
vim.o.swapfile = false
vim.o.guifont = 'JetBrainsMono NFM:h18'

-- independent clipboard
vim.opt.clipboard = ''

require('tokyonight').setup {
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
  },
}

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

  -- Get the filename (with extension) of the current buffer
  local filename_with_extension = vim.fn.expand '%:t'

  -- Get the filename without the extension
  local filename_without_extension = vim.fn.expand '%:t:r'

  -- Get the file extension of the current buffer
  local file_extension = vim.fn.fnamemodify(filename_with_extension, ':e')

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
  else
    vim.notify('Filetype ' .. filetype .. ' not supported for compile and run')
    return
  end

  vim.api.nvim_feedkeys('i', 'n', true)

  -- local term_buf = vim.fn.termopen(command, { cwd = vim.fn.getcwd() })
  -- vim.fn.termstart(term_buf, {
  --     on_exit = function(_, code)
  --         if code ~= 0 then
  --           vim.notify("Command failed with exit code " .. code)
  --         end
  --     end,
  -- })
end

TerminalShell = ''

if vim.fn.has 'win32' == 1 then
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
vim.api.nvim_set_keymap('n', '<leader>cr', "[[:execute luaeval('CompileAndRun()')<cr>]]", { noremap = true, silent = false, desc = '[C]ompile and [R]un' })

-- Enable line numbers (both absolute and relative)
vim.wo.relativenumber = true

-- Use spaces for indentation
vim.o.expandtab = true

-- "Keep it Centered
-- Create nnoremap mappings
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true, silent = true })
vim.o.hlsearch = true

-- emmet
vim.api.nvim_set_keymap('i', '<C-A>', '<Plug>(emmet-expand-abbr)', { noremap = true, silent = true })

-- "Copy Paste from OS Clipboard
vim.keymap.set('n', '<C-v>', '"+p:silent! %s/\\r//g<cr>', { desc = '[P]aste from system clipboard', noremap = true, silent = true })
vim.keymap.set('i', '<C-v>', '<C-r>*<C-o>:silent! %s/\\r//g<cr>', { desc = '[P]aste from system clipboard', noremap = true, silent = true })

vim.keymap.set('n', '<S-insert>', '"+p:silent! %s/\\r//g<cr>', { desc = '[P]aste from system clipboard', noremap = true, silent = true })
vim.keymap.set('i', '<S-insert>', '<C-r>*<C-o>:silent! %s/\\r//g<cr>', { desc = '[P]aste from system clipboard', noremap = true, silent = true })

vim.keymap.set('x', '<C-c>', '"+y', { desc = '[Y]ank to system clipboard', noremap = true, silent = true })
vim.keymap.set('x', '<C-insert>', '"+y', { desc = '[Y]ank to system clipboard', noremap = true, silent = true })

-- "Database Toggle UI"
vim.keymap.set('n', '<leader>db', ':DBUIToggle<cr>', { desc = '[D]ata[b]ase', noremap = true, silent = true })

-- Map Ctrl+S to save
vim.keymap.set('n', '<D-s>', ':w<cr>:mksession! session.vim<cr>', { desc = '[^s] Save Current File', noremap = true, silent = true })
vim.keymap.set('i', '<D-s>', '<Esc>:w<cr>:mksession! session.vim<cr>a', { desc = '[^s] Save Current File', noremap = true, silent = true })
vim.keymap.set('n', '<C-S>', ':w<cr>:mksession! session.vim<cr>', { desc = '[^s] Save Current File', noremap = true, silent = true })
vim.keymap.set('i', '<C-S>', '<Esc>:w<cr>:mksession! session.vim<cr>a', { desc = '[^s] Save Current File', noremap = true, silent = true })

-- "Tab Navigation
vim.keymap.set('n', '<leader><up>', ':tabnew<CR>', { desc = 'New Tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader><right>', ':tabnext<CR>', { desc = 'Next Tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader><left>', ':tabprevious<CR>', { desc = 'Previous Tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader><down>', ':tabclose<CR>', { desc = 'Close Tab', noremap = true, silent = true })

-- nerdtree
vim.keymap.set('n', '<c-z>', ':NvimTreeToggle<cr>', { desc = 'Show File Explorer', noremap = true, silent = true })

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

function RunCommandAndNotify(command)
  vim.notify('Run Command...', vim.log.levels.INFO, {
    title = 'Run Command',
    timeout = 36000000,
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

vim.keymap.set('n', '<leader>gs', function()
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
end, { desc = '[G]it [S]tatus' })

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

-- macos
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

vim.api.nvim_set_keymap('i', '<D-v>', '<C-r>*', { noremap = true, silent = false })

-- npm / yarn operation
vim.api.nvim_set_keymap('n', '<leader>rb', ':lua RunCommandAndNotify("npm run build")<CR>', { noremap = true, silent = false, desc = '[R]un [B]uild' })
vim.api.nvim_set_keymap('n', '<leader>rd', ':lua RunCommandInNewTab("npm run dev")<CR>', { noremap = true, silent = false, desc = '[R]un [D]ev' })
vim.api.nvim_set_keymap('n', '<leader>ri', ':lua Npm_install()<CR>', { noremap = true, silent = false, desc = '[R]un npm [I]nstall' })

-- clear highlight after search by pressing return
vim.api.nvim_set_keymap('n', '<leader>cl', ':noh<CR>', { noremap = true, silent = true, desc = '[C][l]ear Search' })

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
vim.api.nvim_set_keymap('n', '<leader>sl', ':source session.vim<cr>', { noremap = true, silent = false, desc = '[S]ession [L]oad' })
vim.api.nvim_set_keymap('n', '<leader>nq', ':qa!<cr>', { noremap = true, silent = false, desc = '[N]vim [Q]uit' })

-- ChatGPT
vim.keymap.set('n', '<leader>ct', ':ChatGPT<cr>', { noremap = true, silent = false, desc = '[C]hatGP[T]' })
vim.keymap.set('n', '<leader>cc', ':ChatGPTCompleteCode<cr>', { noremap = true, silent = false, desc = '[C]hatGPT [C]ode Completion' })
vim.keymap.set('n', '<leader>ce', ':ChatGPTRun explain_code<cr>', { noremap = true, silent = false, desc = '[C]hatGPT [E]xplain Code' })
vim.keymap.set('n', '<leader>cf', ':ChatGPTRun fix_bugs<cr>', { noremap = true, silent = false, desc = '[C]hatGPT [F]ix Bugs' })

-- vim signature help
vim.api.nvim_set_keymap('n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })

function InsertConsoleLog()
  local line_number = vim.fn.line '.'
  local current_file = '🚀 : ' .. vim.fn.expand '%:t'
  local log_statement = string.format("console.log('%s:%d');", current_file, line_number + 1)
  vim.fn.append(line_number, log_statement)
end

vim.api.nvim_set_keymap('n', '<Leader>lg', [[:lua InsertConsoleLog()<CR>]], { noremap = true, silent = true, desc = 'console.log file and line' })

vim.cmd [[command! EditInitVim :tabnew | exe 'edit '. stdpath('config').'/lua/custom/plugins/init.lua']]
vim.cmd [[command! LoadInitVim :tabnew | exe ':te git -C '. stdpath("config") .' pull' ]]
vim.cmd [[command! EditGlobalSnippets :tabnew | exe 'edit ~/git/friendly-snippets/snippets/global.json']]

vim.g.jupyter_mapkeys = 0
vim.g.jupyter_highlight_cells = 1
vim.g.jupyter_cell_separators = { '# %%', '# <codecell>' }
vim.o.encoding = 'utf-8'

-- jupyter
vim.keymap.set('n', '<leader>jc', ':JupyterConnect<CR>', { noremap = true, silent = false, desc = '[J]upyter [C]onnect' })
vim.keymap.set('n', '<leader>jf', ':JupyterRunFile<CR>', { noremap = true, silent = false, desc = '[J]upyter Run [F]ile' })
vim.keymap.set('n', '<leader>jb', 'i# ---<cr><esc>', { noremap = true, silent = false, desc = '[J]upyter [B]lock' })
vim.keymap.set('n', '<leader>jr', '/# ---<cr>VN:JupyterSendRange<CR><C-o><C-o>', { noremap = true, silent = false, desc = '[J]upyter [R]un Selected' })
vim.keymap.set(
  'n',
  '<leader>js',
  ':vertical terminal ' .. TerminalShell .. '<CR>ijupyter console<cr><C-\\><C-N>:norm G<CR><C-w><C-w>:sleep 1000m<CR>:JupyterConnect<CR>',
  { desc = '[J]upyter Con[s]ole', noremap = false, silent = true }
)

-- auto format
vim.keymap.set('n', '<leader>ff', ':Format<CR>', { noremap = true, silent = false, desc = '[F]ormat' })

-- Search and Replace
vim.keymap.set('n', '<leader>sr', ':%s///g<left><left><left>', { noremap = true, silent = false, desc = '[S]earch and [R]eplace' })

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

vim.keymap.set(
  'n',
  '<leader>fnp',
  ":lua NextJSNewPage(vim.fn.input('Enter Page Name: '))<CR>",
  { noremap = true, silent = false, desc = '[F]ramework [N]extJS New [P]age' }
)
vim.keymap.set(
  'n',
  '<leader>fnr',
  ":lua NextJSNewApiPost(vim.fn.input('Enter Route Name: '))<CR>",
  { noremap = true, silent = false, desc = '[F]ramework [N]extJS New Post [R]oute' }
)
vim.keymap.set(
  'n',
  '<leader>fng',
  ":lua NextJSNewApiGet(vim.fn.input('Enter Route Name: '))<CR>",
  { noremap = true, silent = false, desc = '[F]ramework [N]extJS New [G]et Route' }
)
vim.keymap.set(
  'n',
  '<leader>fsp',
  ":lua SvelteKitNewPage(vim.fn.input('Enter Page Name: '))<CR>",
  { noremap = true, silent = false, desc = '[F]ramework [S]veltekit New [P]age' }
)
vim.keymap.set(
  'n',
  '<leader>fsr',
  ":lua SvelteKitNewAPIPost(vim.fn.input('Enter Route Name: '))<CR>",
  { noremap = true, silent = false, desc = '[F]ramework [S]veltekit New Post [R]oute' }
)
vim.keymap.set(
  'n',
  '<leader>fsg',
  ":lua SvelteKitNewAPIGet(vim.fn.input('Enter Route Name: '))<CR>",
  { noremap = true, silent = false, desc = '[F]ramework [S]veltekit New [G]et Route' }
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

-- nvimtree setup

local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 't', api.node.open.tab, opts 'Open: New Tab')
  vim.keymap.set('n', 'v', api.node.open.vertical, opts 'Open: Vertical Split')
  vim.keymap.set('n', 'x', api.node.open.horizontal, opts 'Open: Horizontal Split')
  vim.keymap.set('n', 'm', api.fs.rename_full, opts 'Rename: Full Path')
end

local ls = require 'luasnip'
ls.config.set_config {
  store_selection_keys = '<tab>',
}

return {
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
    'jupyter-vim/jupyter-vim',
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
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
  -- copilot
  {
    'zbirenbaum/copilot.lua',
    enabled = true,
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {}
    end,
    opts = {
      suggestion = { enabled = true, auto_trigger = true },
      panel = { enabled = false },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
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
        update_focused_file = {
          enable = true,
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
          dotfiles = true,
        },
      }
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-treesitter.configs').setup {
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
  {
    'smoka7/multicursors.nvim',
    event = 'VeryLazy',
    dependencies = {
      'smoka7/hydra.nvim',
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
}
