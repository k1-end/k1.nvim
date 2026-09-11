-- Modern LSP setup using native vim.lsp.config / vim.lsp.enable (Nvim 0.11+).
-- Per-server overrides live in lua/k1/lsp/servers/<name>.lua and are merged
-- on top of nvim-lspconfig's defaults shipped in lsp/<name>.lua.

-- Capabilities (add cmp-nvim-lsp if available)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- LspAttach: buffer-local keymaps + document highlight
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  group = vim.api.nvim_create_augroup('k1-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    local builtin = require('telescope.builtin')

    map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
    map('gr', builtin.lsp_references, '[G]oto [R]eferences')
    map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('gs', vim.lsp.buf.signature_help, '[G]oto [S]ignature help')
    map('<leader>of', vim.diagnostic.open_float, '[O]pen [F]loat')
    map('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
    map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
    map('<leader>ih', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, '[I]nlay [H]int')

    vim.keymap.set({ 'n', 'x' }, '<M-F>', function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = event.buf, desc = 'LSP: [F]ormat Buffer' })

    -- Document highlight on cursor hold
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_augroup('k1-lsp-doc-highlight-' .. event.buf, { clear = true })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = 'k1-lsp-doc-highlight-' .. event.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = 'k1-lsp-doc-highlight-' .. event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- Server registry: name -> config table (loaded from lua/k1/lsp/servers/<name>.lua).
-- Names without an override file just use nvim-lspconfig's defaults.
local servers = {
  intelephense = {},
  ts_ls = {},
  sqlls = {},
  pylsp = require('k1.lsp.servers.pylsp'),
  lua_ls = require('k1.lsp.servers.lua_ls'),
  phpactor = require('k1.lsp.servers.phpactor'),
  html = require('k1.lsp.servers.html'),
}

for name, config in pairs(servers) do
  config = vim.tbl_deep_extend('keep', config, { capabilities = capabilities })
  vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(servers))
