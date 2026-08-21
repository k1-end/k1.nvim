return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    provider = "opencode",
    auto_suggestions_provider = "opencode-go",
    providers = {
      ["opencode-go"] = {
        __inherited_from = "openai",
        endpoint = "https://opencode.ai/zen/go/v1",
        model = "mimo-v2.5",
        api_key_name = "OPENCODE_API_KEY",
        timeout = 10000,
        extra_request_body = {
          max_tokens = 1024,
        },
      },
    },
    behaviour = {
      auto_suggestions = true,
    },
    input = {
      provider = "snacks",
    },
  },
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
