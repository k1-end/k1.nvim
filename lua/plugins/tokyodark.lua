return {
    "tiagovla/tokyodark.nvim",
    opts = {
            transparent_background = true, -- set background to transparent
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
        vim.cmd [[colorscheme tokyodark]]
    end,
}
