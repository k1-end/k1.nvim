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

vim.keymap.set("n", "J", "mzJ`z")          -- joining lines
vim.keymap.set('n', '<leader>fg', ':G<CR>:Neotree close<CR><C-w><C-o>')
vim.keymap.set('i', '<C-e>', '<C-o>$')       -- go to the end of the line in insert mode
vim.keymap.set('i', '<C-d>', '<C-o>dw')       -- delete one word forward in insert mode
vim.keymap.set("n", "<leader>o", ":OilHere")
vim.keymap.set("n", "<leader>ot", ":Neotree reveal_force_cwd<CR>")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("v", "<leader>y", [[mzy`z]])

vim.keymap.set("n", "<M-j>", ":cnext<CR>")
vim.keymap.set("n", "<M-k>", ":cprevious<CR>")

vim.keymap.set("n", "<leader>qq", ":q!<CR>")

vim.keymap.set("n", "<leader>ft", ":FloatermToggle<CR>")
vim.keymap.set("t", "<leader>ft", "<C-\\><C-n>:FloatermToggle<CR>")

vim.api.nvim_create_user_command('OilHere', function()
  vim.cmd('highlight OilCurrentFile guibg=#999222 guifg=#000000')
  require('oil').open()
  vim.defer_fn(function()
      vim.api.nvim_buf_add_highlight(
        0,
        -1,
        'OilCurrentFile',
        vim.fn.line('.') - 1,  -- lines are 0-indexed
        2,               -- start column
        -1               -- end column (-1 for end of line)
      )
  end, 200)  -- Increased delay to ensure Oil is fully rendered
end, {})

vim.api.nvim_create_user_command('YankFileName', function()
    vim.cmd('let @" = expand("%:t")')
end, {})



vim.api.nvim_create_user_command('Glol', function()
    vim.cmd('Git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"')
end, {})

vim.api.nvim_create_user_command('YankRelativePath', function()
  local path = vim.fn.expand('%')
  vim.fn.setreg('"', path)
  vim.notify('Yanked relative path: ' .. path)
end, {})
