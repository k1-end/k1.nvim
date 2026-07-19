# neovim config

Personal Neovim configuration, heavily inspired by [ThePrimeagen/init.lua](https://github.com/ThePrimeagen/init.lua), [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), and [TJ DeVries](https://github.com/tjdevries).

## Structure

```
init.lua                       # Entry point — sets leaders, bootstraps lazy.nvim, loads k1
lua/k1/
  g.lua                        # vim.g (leader keys — must run before lazy)
  options.lua                  # vim.opt / vim.o
  autocmds.lua                 # filetype folds, quickfix, cfilter, yank highlight, win32 shell
  keymaps.lua                  # vanilla keymaps (plugin keys live in their specs)
  commands.lua                 # user commands (OilHere, YankFileName, Glol, YankPathLine, …)
  laravel.lua                  # GoToView / GoToRoute user commands
  lsp/
    init.lua                   # LspAttach autocmd + capabilities + per-server setup loop
    servers/{pylsp,lua_ls,phpactor,html}.lua
lua/plugins/                   # Grouped lazy.nvim specs (one file per domain)
  ai.lua                       # opencode + snacks
  cmp.lua                      # nvim-cmp + LuaSnip + cmp-* + friendly-snippets
  db.lua                       # vim-dadbod-ui + dadbod-completion
  editor.lua                   # comment, surround, autopairs, conform, mini.align/indentscope/icons,
                               #   treesitter-context, undotree, quickmath, foldtext, beacon,
                               #   neoscroll, smear-cursor, nvim-colorizer, todo-comments, vonr/align
  files.lua                    # oil + oil-git-status + neo-tree + window-picker
  fuzzy.lua                    # telescope + harpoon
  git.lua                      # gitsigns + fugitive
  lsp.lua                      # nvim-lspconfig + mason + mason-tool-installer
  markdown.lua                 # obsidian + render-markdown + markdown-preview
  ui.lua                       # rose-pine, lualine, notify, which-key, dressing, fidget, alpha,
                               #   treesitter, nvim-web-devicons, floaterm
after/queries/blade/           # Custom treesitter queries for Blade
spell/                         # Personal word list
```

## Plugin Manager

[lazy.nvim](https://github.com/folke/lazy.nvim) — auto-installed on first run. Each grouped spec file returns a list of specs; configs are inlined via `config = function()` so there are no `after/plugin/*.lua` files.

## Colorscheme

[Rose Pine](https://github.com/rose-pine/neovim) — `moon` variant (applied in `lua/plugins/ui.lua`).

## Categories

| Area | Plugins |
|------|---------|
| **LSP** | nvim-lspconfig, mason.nvim, mason-tool-installer.nvim |
| **Completion** | nvim-cmp, LuaSnip, friendly-snippets |
| **Formatting** | conform.nvim (stylua / jq / pint / sql-formatter / trim_whitespace) |
| **Fuzzy finder** | telescope.nvim, snacks.picker |
| **File explorer** | oil.nvim (edit dirs as buffers), neo-tree.nvim (sidebar) |
| **Git** | vim-fugitive, gitsigns.nvim |
| **Statusline** | lualine.nvim |
| **Navigation** | harpoon |
| **AI** | opencode.nvim |
| **Editing** | vim-surround, Comment.nvim, nvim-autopairs, align.nvim |
| **Notetaking** | obsidian.nvim |
| **Database** | vim-dadbod-ui |
| **Markdown** | render-markdown.nvim, markdown-preview.nvim |

## Language Support

- **PHP/Laravel** — intelephense + phpactor, per-project `vendor/bin/pint` formatter, custom Blade treesitter queries, GoToView/GoToRoute commands
- **TypeScript/JavaScript** — ts_ls
- **Python** — pylsp (with rope_autoimport)
- **Lua** — lua_ls, stylua formatter
- **Go** — fold settings via FileType autocmd
- **SQL** — sqlls, vim-dadbod-completion, sql-formatter
- **HTML/Blade** — html language server (filetypes: html, blade)

## Notes

- LSP uses the modern direct-setup pattern (`lspconfig[name].setup{}` in a loop), not the deprecated `mason-lspconfig` handler API.
- Laravel Pint formatter prefers `./vendor/bin/pint` if present, otherwise falls back to global `pint` on `$PATH`.
- `vim.notify` is wired to `nvim-notify` inside the notify spec config.
