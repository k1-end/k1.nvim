vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':noh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>nrw", vim.cmd.Ex) -- netrw
vim.keymap.set({"v", "n"}, "<leader>ys", "\"+y") -- yank to system clipboard

-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- moving lines
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- moving lines

vim.keymap.set("n", "<leader>gp", ":G push")
vim.keymap.set("n", "<leader>gl", ":G pull")

vim.keymap.set("n", "J", "mzJ`z")            -- joining lines
vim.keymap.set('n', '<leader>fg', ':G<CR>:Neotree close<CR><C-w><C-o>')
vim.keymap.set('i', '<C-e>', '<C-o>$')       -- go to the end of the line in insert mode
vim.keymap.set('i', '<C-d>', '<C-o>dw')       -- go to the end of the line in insert mode
vim.keymap.set("n", "<leader>o", ":OilHere")
vim.keymap.set("n", "<leader>ot", ":Neotree reveal_force_cwd<CR>")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("v", "<leader>y", [[mzy`z]])

vim.keymap.set("n", "<M-j>", ":cnext<CR>")
vim.keymap.set("n", "<M-k>", ":cprevious<CR>")


vim.keymap.set("n", "<leader>ft", ":FloatermToggle<CR>")
vim.keymap.set("t", "<leader>ft", "<C-\\><C-n>:FloatermToggle<CR>")

vim.api.nvim_create_user_command('OilHere', function()
    local buf_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":p:h")
    local file_name = vim.fn.expand("%:t")
    vim.cmd("Oil " .. buf_path)
    -- vim.api.nvim_command("/" .. file_name) -- Perform the search
     -- Delay the search slightly to allow Oil to open
    vim.defer_fn(function()
        vim.api.nvim_command("nohlsearch") 
        vim.api.nvim_command("set hlsearch") 
        vim.api.nvim_command("/\\v" .. file_name) 
    end, 100)
end, {})

vim.api.nvim_create_user_command('YankFileName', function()
      vim.cmd('let @" = expand("%:t")')
end, {})



vim.api.nvim_create_user_command('Glol', function()
    vim.cmd('Git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"')
end, {})
