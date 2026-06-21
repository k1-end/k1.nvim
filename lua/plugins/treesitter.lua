return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.config")

      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc","javascript", "html", "php", "python", "markdown", "markdown_inline"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })

      local parser_config = require("nvim-treesitter.parsers")
      parser_config.blade = {
          install_info = {
              url = "https://github.com/EmranMR/tree-sitter-blade",
              files = { "src/parser.c" },
              branch = "main",
          },
          filetype = "blade",
      }
      vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
      vim.api.nvim_create_autocmd("BufNewFile", {
          group = "BladeFiltypeRelated",
          pattern = "*.blade.php",
          callback = function() vim.bo.filetype = "blade" end,
      })
      vim.api.nvim_create_autocmd("BufRead", {
          group = "BladeFiltypeRelated",
          pattern = "*.blade.php",
          callback = function() vim.bo.filetype = "blade" end,
      })
    end
 }
