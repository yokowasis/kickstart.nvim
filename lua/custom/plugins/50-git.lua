-- "Git Mapping
function GitPullAndNotify()
  vim.notify('Pull Processing...', vim.log.levels.INFO, {
    title = 'Git',
    timeout = 36000000,
  })

  vim.fn.jobstart('git pull --rebase', {
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

  vim.fn.jobstart('git pull --rebase && git push', {
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
  vim.cmd [[Neotree close]]
  vim.cmd [[vertical Git]]
  vim.cmd [[vertical resize -30]]
  vim.cmd [[wincmd H]]
end

function CreateBranchAndPush(branchName)
  RunCommandAndNotify('git checkout -b ' .. branchName .. ' && git push -u origin ' .. branchName)
end

vim.keymap.set('n', '<c-q>', [[:lua OpenGitStatus()<cr>]], {
  desc = '[G]it [S]tatus',
})
vim.keymap.set('n', '<leader>gs', [[:lua OpenGitStatus()<cr>]], {
  desc = '[G]it [S]tatus',
})

function GitCommit(commitMessage)
  RunCommandAndNotify('git add . && git commit -m "' .. commitMessage .. '"')
end

vim.keymap.set('n', '<leader>ga', function()
  local branchName = vim.fn.input 'Enter commit message: '
  if branchName == '' then
    return
  end

  CreateBranchAndPush(branchName)

end, {
  desc = '[G]it [A]dd Branch',
  noremap = true,
  silent = false,
})


vim.keymap.set('n', '<leader>gc', function()
  local commitMessage = vim.fn.input 'Enter commit message: '
  if commitMessage == '' then
    return
  end

  GitCommit(commitMessage)
end, {
  desc = '[G]it [C]ommit',
  noremap = true,
  silent = false,
})

vim.keymap.set('n', '<leader>gh', ':0Gclog<CR>', {
  desc = '[G]it File [H]istory',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gp', [[:lua GitPushAndNotify()<CR>]], {
  desc = '[G]it [P]ush',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gu', [[:lua GitPullAndNotify()<CR>]], {
  desc = '[G]it P[u]ll',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gd', ':vertical Git diff<CR>', {
  desc = '[G]it [D]iff',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gb', ':vertical Git branch -a<CR>', {
  desc = '[G]it [B]ranch',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gv', ':Gvdiffsplit<CR>', {
  desc = '[G]it [V]ertical Diff Current File',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gl', ':vertical Git log<CR>', {
  desc = '[G]it [L]og',
  noremap = true,
  silent = true,
})

vim.api.nvim_create_user_command("GitInitPush", function()
  local username = "yokowasis"
  local repo = vim.fn.fnamemodify(vim.loop.cwd(), ":t")
  if repo == "" then
    print("Could not determine repository name from current directory")
    return
  end
  local remote = "https://github.com/" .. username .. "/" .. repo .. ".git"
  local cmd = "git init && git add . && git commit -m \"Initial commit\" && git branch -M main && gh repo create " .. repo .. " --private --source=. --remote=origin --push"
  vim.cmd("terminal " .. cmd)
end, {})

vim.keymap.set('n', '<leader>gi', ':GitInitPush<CR>', {
  desc = '[G]it [I]nit and Push',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>coo', '04e<right>v$<left>y:Git checkout <c-r>"<cr>', {
  desc = 'Checkout Origin Branch',
  noremap = true,
  silent = true,
})

return {}
