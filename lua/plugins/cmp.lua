return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources(
          { { name = 'nvim_lsp' }, { name = 'luasnip' } },
          { { name = 'buffer' } }
        ),
      })

      -- `/` cmdline setup.
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
      })

      -- SQL completion via vim-dadbod-completion
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'sql', 'mysql', 'plsql' },
        callback = function()
          require('cmp').setup.buffer({ sources = { { name = 'vim-dadbod-completion' } } })
        end,
      })
    end,
  },

  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()

      local ls = require('luasnip')
      vim.keymap.set({ 'i' }, '<C-K>', function() ls.expand() end, { silent = true, desc = 'LuaSnip expand' })
      vim.keymap.set({ 'i', 's' }, '<C-L>', function() ls.jump(1) end, { silent = true, desc = 'LuaSnip next' })
      vim.keymap.set({ 'i', 's' }, '<C-J>', function() ls.jump(-1) end, { silent = true, desc = 'LuaSnip prev' })
      vim.keymap.set({ 'i', 's' }, '<C-E>', function()
        if ls.choice_active() then ls.change_choice(1) end
      end, { silent = true, desc = 'LuaSnip choice' })
    end,
  },
}
