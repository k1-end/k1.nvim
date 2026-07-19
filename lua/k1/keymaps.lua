-- Terminal escape
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Clear search highlight + save
vim.keymap.set('n', '<C-l>', ':noh<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- netrw + system clipboard yank
vim.keymap.set('n', '<leader>nrw', vim.cmd.Ex, { desc = '[N]etrw' })
vim.keymap.set({ 'v', 'n' }, '<leader>ys', '"+y', { desc = '[Y]ank to [S]ystem clipboard' })

-- Search-centered navigation
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Move selected lines up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Join lines preserving cursor
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines preserving cursor' })

-- Git push / pull via fugitive
vim.keymap.set('n', '<leader>gp', ':G push<CR>', { desc = '[G]it [P]ush' })
vim.keymap.set('n', '<leader>gl', ':G pull<CR>', { desc = '[G]it Pul[l]' })
vim.keymap.set('n', '<leader>fg', ':G<CR>:Neotree close<CR><C-w><C-o>', { desc = '[F]u[g]itive — open :G and close neotree' })

-- Insert-mode cursor movement
vim.keymap.set('i', '<C-e>', '<C-o>$', { desc = 'End of line' })
vim.keymap.set('i', '<C-d>', '<C-o>dw', { desc = 'Delete word forward' })

-- File explorers (commands are user-defined)
vim.keymap.set('n', '<leader>o', ':OilHere<CR>', { desc = '[O]pen Oil here' })
vim.keymap.set('n', '<leader>ot', ':Neotree reveal_force_cwd<CR>', { desc = '[O]pen neo-[T]ree' })

-- Paste without yanking
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = '[P]aste without yanking' })
vim.keymap.set('v', '<leader>y', [[mzy`z]], { desc = '[Y]ank preserving cursor' })

-- Quickfix navigation
vim.keymap.set('n', '<M-j>', ':cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '<M-k>', ':cprevious<CR>', { desc = 'Previous quickfix item' })

-- Window quit
vim.keymap.set('n', '<leader>qq', ':q!<CR>', { desc = '[Q]uit window (force)' })

-- Floaterm
vim.keymap.set('n', '<leader>ft', ':FloatermToggle<CR>', { desc = '[F]loat [T]erm toggle' })
vim.keymap.set('t', '<leader>ft', '<C-\\><C-n>:FloatermToggle<CR>', { desc = '[F]loat [T]erm toggle' })

-- Yank path:line
vim.keymap.set('n', '<leader>yl', ':YankPathLine<CR>', { desc = '[Y]ank [L]ine — path:line to clipboard' })
