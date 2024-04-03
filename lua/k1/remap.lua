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

vim.keymap.set("n", "gp", ":G push<CR>")
vim.keymap.set("n", "gl", ":G pull<CR>")

vim.keymap.set("n", "J", "mzJ`z")            -- joining lines
vim.keymap.set('n', '<leader>fg', ':G<CR>:Neotree close<CR><C-w><C-o>')
vim.keymap.set('i', '<C-e>', '<C-o>$')       -- go to the end of the line in insert mode
vim.keymap.set("n", "<leader>o", ":Neotree toggle<CR>")
