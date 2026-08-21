local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')

local function large_file_previewer(opts)
    local filepath = opts.path
    if filepath and vim.fn.getfsize(filepath) > 1048576 then
        return previewers.new_buffer_previewer({})
    end
    return previewers.file_previewer(opts)
end

require('telescope').setup{
    defaults = {
        file_previewer = large_file_previewer,
    },
    pickers = {
        live_grep = {
            theme = "dropdown",
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
        },
    },
}

require('telescope').load_extension('fzf')
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>tr', builtin.resume, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('x', '<leader>ss', '"zy<Cmd>Telescope live_grep<CR><C-r>z', {desc = '[S]earch [S]elecetd text'} )
