return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('mason').setup({})
      require('mason-tool-installer').setup({
        ensure_installed = {
          -- LSP servers (Mason package names)
          'intelephense',
          'typescript-language-server',
          'sqlls',
          'lua-language-server',
          'python-lsp-server',
          'phpactor',
          'html-lsp',
          -- Formatters
          'stylua',
          'jq',
          'sql-formatter',
        },
        auto_update = false,
        run_on_start = true,
      })
      require('k1.lsp')
    end,
  },
}
