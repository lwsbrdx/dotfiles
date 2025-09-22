return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
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
        end,
    },
}
