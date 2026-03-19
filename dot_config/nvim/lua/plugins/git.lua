return {
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        config = function()
            local gs = require("gitsigns")
            gs.setup({
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                current_line_blame = true, -- active le blame en ligne comme GitLens
                current_line_blame_opts = {
                    delay = 500,
                    virt_text_pos = "eol",
                },
            })

            vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next hunk" })
            vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Prev hunk" })
            vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
            vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
            vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
        end,
    },
}
