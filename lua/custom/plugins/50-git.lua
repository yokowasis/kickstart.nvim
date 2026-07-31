-- "Git Mapping
function GitPullAndNotify()
  vim.notify('Pull Processing...', vim.log.levels.INFO, {
    title = 'Git',
    timeout = 5000, -- 5 seconds instead of 10 hours
  })

  vim.fn.jobstart(cmd_to_run 'git fetch --all && git pull --rebase', {
    on_stdout = function(id, data, e) notif(id, data, e, 4000) end,
    on_stderr = function(id, data, e) notif(id, data, e, 4000) end,
    on_exit = function(id, data, e) notif(id, data, e, 4000) end,
  })
end

function GitPushAndNotify()
  vim.notify('Push Processing...', vim.log.levels.INFO, {
    title = 'Git',
    timeout = 5000, -- 5 seconds instead of 10 hours
  })

  vim.fn.jobstart(cmd_to_run 'git pull --rebase && git push', {
    on_stdout = function(id, data, e) notif(id, data, e, 4000) end,
    on_stderr = function(id, data, e) notif(id, data, e, 4000) end,
    on_exit = function(id, data, e) notif(id, data, e, 4000) end,
  })
end

function CreateBranchAndPush(branchName) RunCommandAndNotify('git checkout -b ' .. branchName .. ' && git push -u origin ' .. branchName) end

vim.keymap.set('n', '<c-e>', ':Telescope git_status<cr>', {
  desc = '[G]it [S]tatus',
})

function GitCommit(commitMessage) RunCommandAndNotify('git add . && git commit -m "' .. commitMessage .. '"') end

function UndoCommit()
  local n = vim.fn.input 'Enter number of commits to undo: '
  RunCommandAndNotify('git reset --soft HEAD~' .. n)
end

vim.keymap.set('n', '<leader>gx', UndoCommit, { desc = 'Discard changes in last commit (Undo Commit)' })

vim.keymap.set('n', '<leader>ga', function()
  local branchName = vim.fn.input 'Enter New Branch Name: '
  if branchName == '' then return end

  CreateBranchAndPush(branchName)
end, {
  desc = '[G]it [A]dd Branch',
  noremap = true,
  silent = false,
})

local function secure_git_pull()
  -- Prompt user for explicit confirmation
  vim.ui.input({ prompt = 'Wipe local changes and pull? (y/n): ' }, function(input)
    -- Normalize input to lowercase
    if input and input:lower() == 'y' then
      print '\nStarting Git reset and pull...'

      -- Combine commands into a single string
      local cmd = 'git reset --hard HEAD && git clean -f -d && git pull'
      RunCommandAndNotify(cmd)
    else
      vim.notify('Operation aborted by user.', vim.log.levels.WARN)
    end
  end)
end

-- Keymap registration: Press <leader>gp in Normal mode to trigger
vim.keymap.set('n', '<leader>gr', secure_git_pull, { desc = 'Git: Hard Reset & Pull' })

vim.keymap.set('n', '<leader>gc', function()
  local commitMessage = vim.fn.input 'Enter commit message: '
  if commitMessage == '' then return end

  GitCommit(commitMessage)
end, {
  desc = '[G]it [C]ommit',
  noremap = true,
  silent = false,
})

vim.keymap.set('n', '<leader>gh', ':Telescope git_bcommits<CR>', {
  desc = '[G]it File [H]istory',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gp', GitPushAndNotify, {
  desc = '[G]it [P]ush',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gu', GitPullAndNotify, {
  desc = '[G]it P[u]ll',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<cr>', {
  desc = '[G]it [B]ranch',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gq', function() RunCommandAndNotify 'git add . && git commit -m "Quick Commit" && git push' end, {
  desc = '[G]it [Q]uick Commit and Push',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gl', ':Telescope git_commits<CR>', {
  desc = '[G]it [L]og',
  noremap = true,
  silent = true,
})

vim.api.nvim_create_user_command('GitInitPush', function()
  local username = 'yokowasis'
  local repo = vim.fn.fnamemodify(vim.loop.cwd(), ':t')
  if repo == '' then
    print 'Could not determine repository name from current directory'
    return
  end
  local remote = 'https://github.com/' .. username .. '/' .. repo .. '.git'
  local cmd = 'git init && git add . && git commit -m "Initial commit" && git branch -M main && gh repo create '
    .. repo
    .. ' --private --source=. --remote=origin --push'
  vim.cmd('terminal ' .. cmd)
end, {})

vim.keymap.set('n', '<leader>gi', ':GitInitPush<CR>', {
  desc = '[G]it [I]nit and Push',
  noremap = true,
  silent = true,
})

return {}
