if vim.fn.argc() == 0 then
  vim.defer_fn(function()
    local session_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ".vim"
    local session_path = vim.fn.expand("~/" .. session_name)
    if vim.fn.filereadable(session_path) == 1 then
      vim.cmd("silent! source " .. vim.fn.fnameescape(session_path))
      vim.notify("Session loaded: " .. session_name, vim.log.levels.INFO)
    end
  end, 300) -- Delay the session load by 100ms
end

return {}
