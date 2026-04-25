return {
    "error311/wayfinder.nvim",
    keys = {
        { "<leader>ww", "<Plug>(WayfinderOpen)",      desc = "Ouvrir Wayfinder" },
        { "<leader>ws", "<Plug>(WayfinderTrailShow)",  desc = "Afficher le Trail" },
        { "<leader>wo", "<Plug>(WayfinderTrailOpen)",  desc = "Ouvrir item du Trail" },
        { "<leader>wn", "<Plug>(WayfinderTrailNext)",  desc = "Trail suivant" },
        { "<leader>wp", "<Plug>(WayfinderTrailPrev)",  desc = "Trail précédent" },
    },
    opts = {
        layout = {
            width = 0.88,
            height = 0.72,
        },
    },
}
