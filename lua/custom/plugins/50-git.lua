-- "Git Mapping
function GitPullAndNotify()
  vim.notify('Pull Processing...', vim.log.levels.INFO, {
    title = 'Git',
    timeout = 5000,  -- 5 seconds instead of 10 hours
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
    timeout = 5000,  -- 5 seconds instead of 10 hours
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
  -- Check if neogit is already open
  local neogit_open = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name:match("NeogitStatus") then
      neogit_open = true
      vim.api.nvim_buf_delete(buf, { force = true })
      break
    end
  end
  
  if not neogit_open then
    vim.cmd [[Neotree close]]
    vim.cmd [[Neogit]]
  end
end

function CreateBranchAndPush(branchName)
  RunCommandAndNotify('git checkout -b ' .. branchName .. ' && git push -u origin ' .. branchName)
end

vim.keymap.set('n', '<c-e>', OpenGitStatus, {
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

vim.keymap.set('n', '<leader>gd', '<cmd>Neogit diff<CR>', {
  desc = '[G]it [D]iff',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gb', '<cmd>Neogit branch<CR>', {
  desc = '[G]it [B]ranch',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gv', '<cmd>DiffviewOpen<CR>', {
  desc = '[G]it [V]iew Diff (current file)',
  noremap = true,
  silent = true,
})

vim.keymap.set('n', '<leader>gl', '<cmd>Neogit log<CR>', {
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

vim.keymap.set('n', '<leader>coo', function()
  -- Get current line and extract branch name, then checkout with neogit
  local line = vim.api.nvim_get_current_line()
  local branch = line:match("origin/(.+)")
  if branch then
    vim.cmd('Neogit branch checkout ' .. branch)
  else
    vim.notify('No origin branch found on current line', vim.log.levels.WARN)
  end
end, {
  desc = 'Checkout Origin Branch',
  noremap = true,
  silent = true,
})

return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - for diff view
      "nvim-telescope/telescope.nvim", -- optional - for telescope integration
    },
    config = function()
      require("neogit").setup({
        -- Neogit configuration
        integrations = {
          telescope = true,
          diffview = true,
        },
        sections = {
          untracked = {
            folded = false,
          },
          unstaged = {
            folded = false,
          },
          staged = {
            folded = false,
          },
        },
      })
      
      -- Add keymap to open neogit
      vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', {
        desc = 'Open Neo[g]it',
        noremap = true,
        silent = true,
      })
      
      -- Branch-specific keymaps
      vim.keymap.set('n', '<leader>gbb', '<cmd>Neogit branch<cr>', {
        desc = '[G]it [B]ranch menu',
        noremap = true,
        silent = true,
      })
      
      vim.keymap.set('n', '<leader>gbc', function()
        local branch = vim.fn.input('New branch name: ')
        if branch ~= '' then
          vim.cmd('Neogit branch create ' .. branch)
        end
      end, {
        desc = '[G]it [B]ranch [C]reate',
        noremap = true,
        silent = true,
      })
      
      vim.keymap.set('n', '<leader>gbs', '<cmd>Neogit branch switch<cr>', {
        desc = '[G]it [B]ranch [S]witch',
        noremap = true,
        silent = true,
      })
      
      vim.keymap.set('n', '<leader>gbm', '<cmd>Neogit branch merge<cr>', {
        desc = '[G]it [B]ranch [M]erge',
        noremap = true,
        silent = true,
      })
      
      vim.keymap.set('n', '<leader>gbd', '<cmd>Neogit branch delete<cr>', {
        desc = '[G]it [B]ranch [D]elete',
        noremap = true,
        silent = true,
      })
      
      vim.keymap.set('n', '<leader>gbr', function()
        local branch = vim.fn.input('Remote branch to checkout: ')
        if branch ~= '' then
          -- This will checkout and track the remote branch
          vim.cmd('!git checkout -b ' .. branch .. ' origin/' .. branch)
          vim.cmd('Neogit refresh')
        end
      end, {
        desc = '[G]it [B]ranch checkout [R]emote',
        noremap = true,
        silent = true,
      })
    end,
  }
}
