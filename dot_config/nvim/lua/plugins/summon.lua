return {
    "salkhalil/summon.nvim",
    opts = {},
    config = function ()
        require("summon").setup({
            -- Global defaults (apply to all commands unless overridden)
            width = 0.85,
            height = 0.85,
            border = "rounded",
            close_keymap = "<Esc><Esc>",
            highlights = {
                float = { bg = "#282828" },
                border = { fg = "#d79921", bg = "#282828" },
                title = { fg = "#282828", bg = "#d79921", bold = true },
            },
            -- Colors accept hex strings ("#282828") or integers (0x282828)
            terminal_passthrough_keys = { "<C-o>", "<C-i>" }, -- keys passed to terminal appears

            -- Named commands
            commands = {
                claude = {
                    type = "terminal", -- or "file"
                    command = "claude",
                    title = " Claude-Code ",
                    keymap = "<leader>sc",
                },
                todos = {
                    type = "file",
                    command = "~/Documents/todos.md",
                    title = " TODOs ",
                    keymap = "<leader>st",
                    filetype = "markdown", -- optional: override auto-detected filetype
                },
            },
        })
    end
}
