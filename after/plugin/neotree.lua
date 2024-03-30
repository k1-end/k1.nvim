require("neo-tree").setup({
  window = {
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
    }
  }
})
