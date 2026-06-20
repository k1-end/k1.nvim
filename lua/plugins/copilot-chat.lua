return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = vim.fn.has('win32') == 1 and '' or 'make tiktoken',
    opts = {
            proxy = os.getenv('COPILOT_PROXY') 
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
