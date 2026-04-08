return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        plugins = {
            marks = true,
            registers = true,
        },
        win = {
            col = math.huge,              -- bord droit
            row = math.huge,              -- bord bas
            border = "rounded",
            width = { min = 30, max = 60 }, -- compact, pas pleine largeur
            height = { min = 4, max = 20 },
        },
        layout = {
            spacing = 3,
        },
        spec = {
            { "<leader>f", group = "Files" },
            { "<leader>l", group = "LSP" },
            { "<leader>x", group = "Explorer" },
            { "<leader>d", group = "Debug" },
            { "<leader>g", group = "Git" },
            { "<leader>v", group = "Vim" },
            { "<leader>s", group = "Summon" },
            { "<leader>F", group = "Flutter" },
            { "<leader>t", group = "Test (Java)" },
            { "]",         group = "Next" },
            { "[",         group = "Prev" },
        },
    },
}
