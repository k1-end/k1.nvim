return {
  {
    'folke/snacks.nvim',
    opts = { picker = { enabled = true } },
    keys = {
      { '<leader>ff', function() Snacks.picker.pick('files') end, desc = '[F]ind [F]iles (snacks)' },
    },
  },

  {
    'nickjvandyke/opencode.nvim',
    version = '*',
    dependencies = {
      {
        'folke/snacks.nvim',
        optional = true,
        opts = {
          input = {},
          picker = {
            enabled = true,
            actions = {
              opencode_send = function(picker)
                local items = vim.tbl_map(function(item)
                  return item.file
                      and require('opencode').format({ path = item.file, from = item.pos, to = item.end_pos })
                      or item.text
                end, picker:selected({ fallback = true }))
                require('opencode').prompt(table.concat(items, ', ') .. ' ')
              end,
            },
            win = {
              input = {
                keys = {
                  ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      vim.g.opencode_opts = {}
      vim.o.autoread = true -- Required for `opts.events.reload`

      vim.keymap.set({ 'n', 'x' }, '<C-a>', function() require('opencode').ask('@this: ', { submit = true }) end, { desc = 'Ask opencode…' })
      vim.keymap.set({ 'n', 'x' }, '<C-x>', function() require('opencode').select() end, { desc = 'Execute opencode action…' })
      vim.keymap.set({ 'n', 't' }, '<C-.>', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })

      vim.keymap.set({ 'n', 'x' }, 'go', function() return require('opencode').operator('@this ') end, { desc = 'Add range to opencode', expr = true })
      vim.keymap.set('n', 'goo', function() return require('opencode').operator('@this ') .. '_' end, { desc = 'Add line to opencode', expr = true })

      vim.keymap.set('n', '<S-C-u>', function() require('opencode').command('session.half.page.up') end, { desc = 'Scroll opencode up' })
      vim.keymap.set('n', '<S-C-d>', function() require('opencode').command('session.half.page.down') end, { desc = 'Scroll opencode down' })

      -- Restore default <C-a>/<C-x> increment/decrement since opencode claims them
      vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment under cursor', noremap = true })
      vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement under cursor', noremap = true })
    end,
  },

  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false,
    opts = {
      mode = 'agentic',
      provider = 'opencode-go',
      auto_suggestions_provider = 'opencode-suggest',
      providers = {
        ['opencode-go'] = {
          __inherited_from = 'openai',
          endpoint = 'https://opencode.ai/zen/go/v1',
          model = 'mimo-v2.5',
          api_key_name = 'OPENCODE_API_KEY',
          timeout = 30000,
          extra_request_body = { max_tokens = 16384 },
        },
        ['opencode-suggest'] = {
          __inherited_from = 'openai',
          endpoint = 'https://opencode.ai/zen/go/v1',
          model = 'qwen3.5-plus',
          api_key_name = 'OPENCODE_API_KEY',
          timeout = 30000,
          extra_request_body = { max_tokens = 4096 },
        },
      },
      behaviour = { auto_suggestions = false },
      suggestion = { debounce = 600, throttle = 600 },
      input = { provider = 'snacks' },
    },
    config = function(_, opts)
      require('avante').setup(opts)
      vim.api.nvim_create_user_command('AvanteSwitchMode', function()
        local config = require('avante.config')
        local current = config.mode or 'agentic'
        local choices = current == 'agentic' and { 'agentic', 'legacy' } or { 'legacy', 'agentic' }
        vim.ui.select(choices, { prompt = 'Avante mode (current: ' .. current .. '):' }, function(choice)
          if choice and choice ~= current then
            config.override({ mode = choice })
            vim.notify('Avante mode switched to: ' .. choice, vim.log.levels.INFO)
          end
        end)
      end, {})
    end,
    build = 'make',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'folke/snacks.nvim',
      'nvim-mini/mini.pick',
      'ibhagwan/fzf-lua',
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = { file_types = { 'markdown', 'Avante' } },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
}
