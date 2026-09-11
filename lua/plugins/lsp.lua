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
      local mason_proxy = vim.env.NVIM_MASON_PROXY or 'http://192.168.75.109:2081'
      for _, name in ipairs({ 'HTTP_PROXY', 'HTTPS_PROXY', 'ALL_PROXY' }) do
        vim.env[name] = mason_proxy
        vim.env[name:lower()] = mason_proxy
      end
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
          'gopls',
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
