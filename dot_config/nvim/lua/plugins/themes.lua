return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        opts = {
            transparent = true,
            terminal_colors = true,
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            vim.cmd("colorscheme kanagawa-wave")
        end,
    },
}
