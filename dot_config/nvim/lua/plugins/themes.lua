return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        opts = {
            transparent = false,
            terminal_colors = true,
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            vim.cmd("colorscheme kanagawa-wave")
        end,
    },
}
