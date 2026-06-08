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
            { "<leader>a",  group = "Agentic AI" },
            { "<leader>aa", desc = "Toggle chat" },
            { "<leader>af", desc = "Fichier/sélection → contexte", mode = { "n", "v" } },
            { "<leader>ac", desc = "Nouvelle session" },
            { "<leader>ar", desc = "Restaurer session" },
            { "<leader>as", desc = "Changer de provider" },
            { "<leader>ad", desc = "Diagnostic ligne courante" },
            { "<leader>aD", desc = "Diagnostics du buffer" },
            { "<leader>f", group = "Files" },
            { "<leader>l", group = "LSP" },
            { "<leader>x", group = "Explorer" },
            { "<leader>d", group = "Debug" },
            { "<leader>g", group = "Git" },
            { "<leader>v", group = "Vim" },
            { "<leader>s", group = "Summon" },
            { "<leader>r", group = "Rust" },
            { "<leader>F", group = "Flutter" },
            { "<leader>t", group = "Test (Java)" },
            { "<leader>w", group = "Wayfinder" },
            { "]",         group = "Next" },
            { "[",         group = "Prev" },
        },
    },
}
