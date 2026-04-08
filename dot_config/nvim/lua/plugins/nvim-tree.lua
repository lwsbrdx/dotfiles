return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            view = { width = 50, side = 'right' },
            update_focused_file = { enable = true },
        })

        vim.keymap.set("n", "<leader>xc", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "Toggle l'explorateur de fichiers" })
        vim.keymap.set("n", "<leader>xx", "<cmd>NvimTreeFindFile<cr>", { desc = "Focus sur le fichier dans l'explorateur de fichiers" })
    end,
}
