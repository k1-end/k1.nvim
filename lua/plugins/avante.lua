return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    mode = "agentic", -- "agentic" or "legacy"
    provider = "opencode-go",
    auto_suggestions_provider = "opencode-suggest",
    providers = {
      ["opencode-go"] = {
        __inherited_from = "openai",
        endpoint = "https://opencode.ai/zen/go/v1",
        model = "mimo-v2.5",
        api_key_name = "OPENCODE_API_KEY",
        timeout = 30000,
        extra_request_body = {
          max_tokens = 16384,
        },
      },
      ["opencode-suggest"] = {
        __inherited_from = "openai",
        endpoint = "https://opencode.ai/zen/go/v1",
        model = "qwen3.5-plus",
        api_key_name = "OPENCODE_API_KEY",
        timeout = 30000,
        extra_request_body = {
          max_tokens = 4096,
        },
      },
    },
    behaviour = {
      auto_suggestions = false,
    },
    suggestion = {
      debounce = 600,
      throttle = 600,
    },
    input = {
      provider = "snacks",
    },
  },
  config = function(_, opts)
    require("avante").setup(opts)

    vim.api.nvim_create_user_command("AvanteSwitchMode", function()
      local config = require("avante.config")
      local current = config.mode or "agentic"
      local choices = current == "agentic" and { "agentic", "legacy" } or { "legacy", "agentic" }

      vim.ui.select(choices, {
        prompt = "Avante mode (current: " .. current .. "):",
        format_item = function(item)
          local marker = item == current and " (active)" or ""
          if item == "agentic" then
            return "agentic - uses tools to generate code" .. marker
          else
            return "legacy - old planning method" .. marker
          end
        end,
      }, function(choice)
        if choice and choice ~= current then
          config.override({ mode = choice })
          vim.notify("Avante mode switched to: " .. choice, vim.log.levels.INFO)
        end
      end)
    end, {})
  end,
  build = "make",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "folke/snacks.nvim",
    "nvim-mini/mini.pick",
    "ibhagwan/fzf-lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
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
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
}
