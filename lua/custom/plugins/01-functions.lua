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

function fileExists(fileName)
    local file = io.open(fileName, 'r')
    if file then
        file:close()
        return true
    else
        return false
    end
end

function BuildAndNotify()
    vim.notify('Building Project...', vim.log.levels.INFO, {
        title = 'NPM',
        timeout = 36000000
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
        end
    })
end

function RunCommandInNewTab(command)
    vim.cmd(':-1tabnew | te  ' .. command)
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
        timeout = timeout
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
        end
    })
end

return {}
