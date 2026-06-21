# neovim config

Personal Neovim configuration, heavily inspired by [ThePrimeagen/init.lua](https://github.com/ThePrimeagen/init.lua), [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), and [TJ DeVries](https://github.com/tjdevries).

## Structure

```
init.lua               # Entry point — bootstraps lazy.nvim
lua/k1/                # Core config (settings, keymaps)
lua/plugins/           # Plugin specs (one file per plugin)
after/plugin/          # Plugin configs loaded after setup
after/queries/blade/   # Custom treesitter queries for Blade
```

## Plugin Manager

[lazy.nvim](https://github.com/folke/lazy.nvim) — auto-installed on first run.

## Colorscheme

[Rose Pine](https://github.com/rose-pine/neovim) — moon variant.

## Key Categories

| Area | Plugins |
|------|---------|
| **LSP** | nvim-lspconfig, mason.nvim, mason-lspconfig |
| **Completion** | nvim-cmp, LuaSnip, friendly-snippets |
| **Fuzzy finder** | telescope.nvim |
| **File explorer** | neo-tree.nvim, oil.nvim |
| **Git** | vim-fugitive, gitsigns.nvim |
| **Statusline** | lualine.nvim |
| **Navigation** | harpoon (file bookmarks) |
| **AI** | opencode.nvim, codecompanion.nvim, copilot.lua (disabled) |
| **Editing** | vim-surround, Comment.nvim, nvim-autopairs, formatter.nvim, vonr-align |
| **Notetaking** | obsidian.nvim |
| **Database** | vim-dadbod-ui |
| **Markdown** | render-markdown.nvim, markdown-preview.nvim |

## Language Support

- **PHP/Laravel** — intelephense, phpactor, Pint formatter, custom Blade queries
- **TypeScript/JavaScript** — ts_ls
- **Python** — pylsp (with rope_autoimport)
- **Lua** — lua_ls, stylua formatter
- **Go** — fold settings, gopls
- **SQL** — sqlls, vim-dadbod-completion
- **HTML/Blade** — html language server
