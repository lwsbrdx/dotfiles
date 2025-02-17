return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")

            gitsigns.setup({
                signs = {
                    add = { text = "+" },
                },
                current_line_blame = true,
            })

            vim.keymap.set('n', '<leader>gsb', gitsigns.blame)
            vim.keymap.set('n', '<leader>gsr', gitsigns.reset_hunk)
        end,
    },
}
