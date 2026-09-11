return {
  -- Colorscheme
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        variant = 'auto',
        dark_variant = 'main',
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        enable = {
          terminal = true,
          legacy_highlights = true,
          migrations = true,
        },
        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },
        groups = {
          border = 'muted',
          link = 'iris',
          panel = 'surface',
          error = 'love',
          hint = 'iris',
          info = 'foam',
          note = 'pine',
          todo = 'rose',
          warn = 'gold',
          git_add = 'foam',
          git_change = 'rose',
          git_delete = 'love',
          git_dirty = 'rose',
          git_ignore = 'muted',
          git_merge = 'iris',
          git_rename = 'pine',
          git_stage = 'iris',
          git_text = 'rose',
          git_untracked = 'subtle',
          h1 = 'iris',
          h2 = 'foam',
          h3 = 'rose',
          h4 = 'gold',
          h5 = 'pine',
          h6 = 'foam',
        },
      })
      vim.cmd('colorscheme rose-pine-moon')
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },

  -- Notification UI + global vim.notify
  {
    'rcarriga/nvim-notify',
    lazy = false,
    config = function()
      require('notify').setup({
        background_colour = '#c8caf7',
      })
      vim.notify = require('notify')
    end,
  },

  -- Keymap popup
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').add({
        { '<leader>c', group = '[C]ode' },
        { '<leader>c_', hidden = true },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>d_', hidden = true },
        { '<leader>r', group = '[R]ename' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = '[S]earch' },
        { '<leader>s_', hidden = true },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>w_', hidden = true },
        { 'g', group = 'ali[G]n' },
      })
    end,
  },

  -- UI overhaul for vim.ui.select / input
  { 'stevearc/dressing.nvim', opts = {} },

  -- LSP progress notifications
  { 'j-hui/fidget.nvim', event = 'LspAttach', opts = {} },

  -- Startup dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      local dashboard = require 'alpha.themes.dashboard'
      dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('q', '󰅚  Quit NVIM', ':qa<CR>'),
      }
      dashboard.section.header.val = {
        '                              ',
        '            .-"""-.           ',
        "           '       \\          ",
        '          |,.  ,-.  |         ',
        '          |()L( ()| |         ',
        "          |,'  `\".| |         ",
        "          |.___.',| `         ",
        "        .j `--\"' `  `.       ",
        "        / '        '   \\      ",
        "       / /          `   `.    ",
        "      / /            `    .   ",
        '     / /              l   |   ',
        '    . ,               |   |   ',
        '    ,"`.             .|   |   ',
        " _.'   ``.          | `..-'l  ",
        '|       `.`,        |      `. ',
        '|         `.    __.j         )',
        '|__        |--""___|      ,\'- ',
        '   `"--...,+""""   `._,.-\'    ',
        '                              ',
        '                              ',
        '                              ',
        '                              ',
        '                              ',
      }
      require('alpha').setup(dashboard.config)
    end,
  },

  -- Icons (dep of many UI plugins — configure here)
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({
        override = {
          zsh = { icon = '', color = '#428850', cterm_color = '65', name = 'Zsh' },
        },
        color_icons = true,
        default = true,
        strict = true,
        override_by_filename = {
          ['.gitignore'] = { icon = '', color = '#f1502f', name = 'Gitignore' },
        },
        override_by_extension = {
          ['log'] = { icon = '', color = '#81e043', name = 'Log' },
        },
      })
    end,
  },

  -- Treesitter (new rewrite API — requires Neovim 0.12+ and tree-sitter-cli)
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false, -- upstream: "This plugin does not support lazy-loading."
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
      })

      -- Install parsers asynchronously (no-op if already installed).
      -- Wrapped in pcall so nvim still loads if tree-sitter-cli is absent.
      local ensure_installed = {
        'c', 'lua', 'vim', 'vimdoc', 'javascript', 'html',
        'php', 'python', 'markdown', 'markdown_inline',
      }
      pcall(function()
        require('nvim-treesitter').install(ensure_installed)
      end)

      -- Enable highlight + indent for any filetype with a parser.
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('k1_treesitter_ft', { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- Floating terminal
  { 'voldikss/vim-floaterm' },
}
