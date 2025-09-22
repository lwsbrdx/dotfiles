return {
    -- Thème : TokyoNight
    {
        "folke/tokyonight.nvim",
        lazy = false, -- true: ne charge que si choisi
        opts = {
            style = "night", -- variantes: "storm", "night", "day", "moon"
            transparent = false,
            terminal_colors = true,
        },
        config = function ()
            vim.cmd("colorscheme tokyonight-night")
        end
    },
}
