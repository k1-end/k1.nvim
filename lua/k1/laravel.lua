-- Laravel navigation helpers (no plugin, just user commands).
-- Kept as part of k1/ since these are pure user commands over LSP + `php artisan`.

local function go_to_view()
  local line = vim.fn.getline('.')
  local view = line:match("'(.-)'"):gsub('%.', '/')
  vim.api.nvim_command('edit ./resources/views/' .. view .. '.blade.php')
end

local function go_to_route()
  local line = vim.fn.getline('.')
  local route = line:match("'(.-)'")
  local command = 'php artisan route:list --columns=name,action | grep -i "' .. route .. '"'
  local handle = io.popen(command)
  local result = handle:read('*a')
  handle:close()
  local second_bar_pos = result:find('|', 2)
  local third_bar_pos = result:find('|', second_bar_pos + 1)

  if second_bar_pos and third_bar_pos then
    local extracted = result:sub(second_bar_pos + 1, third_bar_pos - 1)
    extracted = extracted:gsub('^%s*(.-)%s*$', '%1')
    local before_at = extracted:match('(.+)@')
    local after_at = extracted:match('.+@(.+)')
    vim.lsp.buf.workspace_symbol(before_at, {
      on_list = function(options)
        vim.fn.setqflist({}, ' ', options)
        vim.api.nvim_command('cclose')
        vim.api.nvim_command('cfirst')
        vim.lsp.buf.document_symbol({
          on_list = function(opts)
            vim.fn.setqflist({}, ' ', opts)
            vim.api.nvim_command('Cfilter /Method.*' .. after_at .. '/')
            vim.api.nvim_command('cfirst')
            vim.api.nvim_feedkeys('z.', 'n', true)
          end,
        })
      end,
    })
  end
end

vim.api.nvim_create_user_command('GoToView', go_to_view, {})
vim.api.nvim_create_user_command('GoToRoute', go_to_route, {})
