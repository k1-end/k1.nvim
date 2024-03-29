vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':noh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>nrw", vim.cmd.Ex) -- netrw
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- moving lines
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- moving lines
vim.keymap.set("n", "J", "mzJ`z")            -- joining lines
vim.keymap.set('n', '<leader>fg', ':G<CR><C-w><C-w>:q<CR>')
vim.keymap.set('i', '<C-e>', '<C-o>$')       -- go to the end of the line in insert mode

function GTV()
    local line = vim.fn.getline(".")
    local view = line:match("'(.-)'"):gsub("%.", "/")
    vim.api.nvim_command('edit ./resources/views/' .. view .. '.blade.php')
end

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
