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
vim.cmd("autocmd BufWinEnter *.php setlocal foldlevel=4")
vim.cmd("autocmd BufWinEnter *.go setlocal foldmethod=indent")
vim.cmd("autocmd BufWinEnter *.go setlocal foldlevel=4")
vim.cmd("autocmd BufWinEnter *.dbout setlocal foldmethod=manual")
vim.cmd("autocmd BufWinEnter *.dbout setlocal foldlevel=40")
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
vim.opt.conceallevel  = 2
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3 -- Added this line for avante.nvim
vim.notify = require("notify")


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- For transparent background
-- vim.cmd("highlight Normal guibg=none")
-- vim.cmd("highlight NonText guibg=none")
-- vim.cmd("highlight Normal ctermbg=none")
-- vim.cmd("highlight NonText ctermbg=none")

vim.api.nvim_set_hl(0, 'Beacon', { bg = 'white' })
if vim.fn.has('win32') == 1 then
    vim.cmd([[
        let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
        let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
        let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
        let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
        set shellquote= shellxquote=
    ]])

    vim.g.floaterm_shell = 'powershell'
end
