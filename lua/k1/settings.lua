vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4 -- tab size
vim.opt.softtabstop = 4 -- how many tabs to insert when pressing tab
vim.opt.shiftwidth = 4 -- auto-indentation 
vim.opt.expandtab = true -- replace tabs with spaces
vim.o.updatetime = 100
vim.opt.smartindent = true

vim.cmd("colorscheme tokyodark")
vim.cmd("autocmd BufWinEnter *.php setlocal foldmethod=indent")
vim.cmd("autocmd BufWinEnter *.php setlocal foldlevel=40")
vim.cmd("autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>")
vim.cmd("packadd cfilter")

vim.o.ignorecase    = true
vim.o.wrap          = true
vim.o.linebreak     = true
vim.o.arabicshape   = false
vim.opt.showmode    = false
vim.opt.breakindent = true
vim.opt.signcolumn  = 'yes'
vim.opt.splitright  = true
vim.opt.splitbelow  = true
vim.opt.inccommand  = 'split'


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.cmd("set clipboard=unnamedplus") set clipboard to synct

