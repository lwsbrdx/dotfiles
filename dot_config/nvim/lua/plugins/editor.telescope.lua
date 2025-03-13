return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
            })

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>f", builtin.find_files, {})
            vim.keymap.set("n", "<leader>l", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, {})
            vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
            vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, {})
            vim.keymap.set("n", "<leader>b", builtin.buffers, {})
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
