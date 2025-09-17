require("codecompanion").setup({
    adapters = {
        http = {
            myopenai = function()
                return require("codecompanion.adapters").extend("openai", {
                    url = os.getenv("CODECOMPANION_ARVAN_URL"),
                    env = {
                        api_key = os.getenv("CODECOMPANION_ARVAN_API_KEY"),
                    },
                    schema = {
                        model = {
                            default = "GPT-4o-mini",
                        },
                    },
                })
            end,
        },
    },
    strategies = {
        chat = {
          adapter = "myopenai",
        },
        inline = {
          adapter = "myopenai",
        },
        cmd = {
          adapter = "myopenai",
        }
    },
})
