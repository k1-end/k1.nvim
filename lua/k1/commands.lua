-- Open Oil in current window with the current file highlighted
vim.api.nvim_create_user_command('OilHere', function()
  vim.cmd('highlight OilCurrentFile guibg=#999222 guifg=#000000')
  require('oil').open()
  vim.defer_fn(function()
    vim.api.nvim_buf_add_highlight(
      0,
      -1,
      'OilCurrentFile',
      vim.fn.line('.') - 1, -- lines are 0-indexed
      2,                    -- start column
      -1                    -- end column (-1 for end of line)
    )
  end, 200) -- delay to ensure Oil is fully rendered
end, {})

-- Yank just the filename
vim.api.nvim_create_user_command('YankFileName', function()
  local name = vim.fn.expand('%:t')
  vim.fn.setreg('"', name)
  vim.fn.setreg('+', name)
  vim.notify('Yanked file name: ' .. name)
end, {})

-- Dismiss all nvim-notify notifications
vim.api.nvim_create_user_command('ClsNotif', function()
  require('notify').dismiss()
end, {})

-- Pretty git log via fugitive
vim.api.nvim_create_user_command('Glol', function()
  vim.cmd('Git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"')
end, {})

-- Yank the buffer's relative path
vim.api.nvim_create_user_command('YankRelativePath', function()
  local path = vim.fn.expand('%')
  vim.fn.setreg('"', path)
  vim.notify('Yanked relative path: ' .. path)
end, {})

-- Yank path:line (useful for sharing error locations)
vim.api.nvim_create_user_command('YankPathLine', function()
  local path = vim.fn.expand('%:.')
  local line = vim.fn.line('.')
  local text
  if path == '' or path == '.' then
    text = tostring(line)
  else
    text = path .. ':' .. line
  end
  vim.fn.setreg('+', text)
  vim.notify('Yanked: ' .. text)
end, {})
