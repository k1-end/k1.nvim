return {
  -- Comment toggle
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

  -- Surround (cs, ds, ys)
  { 'tpope/vim-surround', event = 'ModeChanged' },

  -- Auto-pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },

  -- Formatting (replaces formatter.nvim)
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { '<M-F>', function() require('conform').format({ async = true, lsp_fallback = true }) end, desc = 'Format buffer' },
    },
    config = function()
      local conform = require('conform')
      conform.setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          json = { 'jq' },
          php = { 'pint' },
          sql = { 'sql_formatter' },
          ['_'] = { 'trim_whitespace' },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters = {
          -- Laravel Pint: prefer project-local ./vendor/bin/pint, fall back to global
          pint = {
            command = 'pint',
            args = { '$FILENAME' },
            stdin = false,
            condition = function(ctx)
              local local_pint = vim.fs.find({ 'vendor/bin/pint' }, { upward = true, path = ctx.filename })[1]
              conform.formatters.pint.command = local_pint or 'pint'
              return true
            end,
          },
        },
      })
    end,
  },

  -- mini.nvim — only indentscope + icons (mini.files dropped: oil covers it; mini.align dropped: vonr/align covers it)
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.indentscope').setup({})
      require('mini.icons').setup({})
    end,
  },

  { 'echasnovski/mini.icons', version = false },

  -- Visual align mode
  {
    'Vonr/align.nvim',
    branch = 'v2',
    lazy = true,
    init = function()
      local NS = { noremap = true, silent = true, desc = 'ali[G]n' }

      vim.keymap.set('x', '<M-a>', function()
        require('align').align_to_char({ length = 1 })
      end, NS)

      vim.keymap.set('x', 'ad', function()
        require('align').align_to_char({ preview = true, length = 2 })
      end, NS)

      vim.keymap.set('x', 'aw', function()
        require('align').align_to_string({ preview = true, regex = false })
      end, NS)

      vim.keymap.set('x', 'ar', function()
        require('align').align_to_string({ preview = true, regex = true })
      end, NS)

      vim.keymap.set('n', 'gaw', function()
        local a = require 'align'
        a.operator(a.align_to_string, { regex = false, preview = true })
      end, NS)

      vim.keymap.set('n', 'gaa', function()
        local a = require 'align'
        a.operator(a.align_to_char)
      end, NS)
    end,
  },

  -- Treesitter context (sticky header)
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  -- Undo tree
  { 'mbbill/undotree', cmd = 'UndotreeToggle' },

  -- Quick math scratch
  { 'jbyuki/quickmath.nvim', cmd = 'Quickmath' },

  -- Custom fold text
  { 'OXY2DEV/foldtext.nvim', lazy = false },

  -- Cursor jump beacon
  {
    'danilamihailov/beacon.nvim',
    event = 'BufReadPost',
    config = function()
      require('beacon').setup({
        min_jump = 2,
        cursor_events = { 'CursorMoved', 'WinScrolled' },
        speed = 1,
      })
    end,
  },

  -- Smooth scrolling
  {
    'karb94/neoscroll.nvim',
    event = 'VeryLazy',
    config = function()
      require('neoscroll').setup({
        mappings = {
          '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', 'zt', 'zz', 'zb',
        },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        duration_multiplier = 0.4,
        easing = 'linear',
        pre_hook = nil,
        post_hook = nil,
        performance_mode = false,
        ignored_events = { 'WinScrolled', 'CursorMoved' },
      })
    end,
  },

  -- Smear cursor animation
  {
    'sphamba/smear-cursor.nvim',
    lazy = false,
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode = true,
    },
  },

  -- Color hex codes
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function() require('colorizer').setup() end,
  },

  -- TODO/FIXME/NOTE highlight
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('todo-comments').setup({}) end,
  },
}
