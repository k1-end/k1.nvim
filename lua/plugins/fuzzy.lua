return {
  {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      require('telescope').setup({
        pickers = {
          live_grep = { theme = 'dropdown' },
        },
      })
      vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>tr', builtin.resume, { desc = '[T]elescope [R]esume' })
      vim.keymap.set('x', '<leader>ss', '"zy<Cmd>Telescope live_grep<CR><C-r>z', { desc = '[S]earch [S]elected text' })
    end,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()

      vim.keymap.set('n', '<leader>a', function() harpoon:list():append() end, { desc = 'Harpoon append' })
      vim.keymap.set('n', '<C-P>', function() harpoon:list():prev() end, { desc = 'Harpoon prev' })
      vim.keymap.set('n', '<C-N>', function() harpoon:list():next() end, { desc = 'Harpoon next' })
      vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon menu' })

      vim.api.nvim_create_user_command('Hprmat', function(opts) require('harpoon'):list():removeAt(tonumber(opts.args)) end, { nargs = 1 })
      vim.api.nvim_create_user_command('Hprm', function() require('harpoon'):list():remove() end, {})
    end,
  },
}
