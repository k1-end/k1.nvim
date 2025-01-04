function GTV()
    local line = vim.fn.getline(".")
    local view = line:match("'(.-)'"):gsub("%.", "/")
    vim.api.nvim_command('edit ./resources/views/' .. view .. '.blade.php')
end


vim.api.nvim_create_user_command('GoToView', function()
    GTV()
end, {})

function GTR()
    local line = vim.fn.getline(".")
    local route = line:match("'(.-)'")
    local command = "php artisan route:list --columns=name,action | grep -i \"" .. route .. "\""
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    local secondBarPos = result:find("|", 2)
    local thirdBarPos = result:find("|", secondBarPos + 1)

    if secondBarPos and thirdBarPos then
        local extractedString = result:sub(secondBarPos + 1, thirdBarPos - 1)
        extractedString = extractedString:gsub("^%s*(.-)%s*$", "%1")
        local beforeAt, _ = extractedString:match("(.+)@")
        local afterAt, _ = extractedString:match(".+@(.+)")
        _G.afterAt = afterAt
        vim.lsp.buf.workspace_symbol(
            beforeAt,
            {
                on_list = function(options)
                    vim.fn.setqflist({}, ' ', options)
                    vim.api.nvim_command('cclose')
                    vim.api.nvim_command('cfirst')
                    vim.lsp.buf.document_symbol(
                        {
                            on_list = function(options)
                                vim.fn.setqflist({}, ' ', options)
                                vim.api.nvim_command('Cfilter /Method.*' .. _G.afterAt .. '/')
                                vim.api.nvim_command('cfirst')
                                vim.api.nvim_feedkeys("z.", "n", true)
                            end
                        }
                    )
                end
            }
        )
    end
end


vim.api.nvim_create_user_command('GoToRoute', function()
    GTR()
end, {})
