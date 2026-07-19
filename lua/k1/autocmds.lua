local augroup = vim.api.nvim_create_augroup

-- Fold settings by filetype (was vim.cmd("autocmd BufRead *.php ..."))
augroup('k1-fold-php-go', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'k1-fold-php-go',
  pattern = { 'php', 'go' },
  callback = function()
    vim.opt_local.foldmethod = 'indent'
    vim.opt_local.foldlevel = 4
  end,
})

augroup('k1-fold-dbout', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'k1-fold-dbout',
  pattern = 'dbout',
  callback = function()
    vim.opt_local.foldmethod = 'manual'
    vim.opt_local.foldlevel = 40
  end,
})

-- Quickfix window: Enter opens and closes
augroup('k1-quickfix', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'k1-quickfix',
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', '<CR>', '<CR>:cclose<CR>', { buffer = true })
  end,
})

-- packadd cfilter (allows :Cfilter in quickfix)
augroup('k1-cfilter', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  group = 'k1-cfilter',
  callback = function() pcall(vim.cmd, 'packadd cfilter') end,
})

-- Highlight on yank
augroup('k1-highlight-yank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = 'k1-highlight-yank',
  callback = function() vim.highlight.on_yank() end,
})

-- Beacon highlight group
vim.api.nvim_set_hl(0, 'Beacon', { bg = 'white' })

-- Win32 shell setup
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
