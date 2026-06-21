return {
  "folke/snacks.nvim",
  opts = {
    picker = { enabled = true },
  },
  keys = {
    { "<leader>ff", function() Snacks.picker.pick("files") end, desc = "Find files" },
  },
}
