return {
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},
    },
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = { "amansingh-afk/milli.nvim" },
        opts = function()
            local splash = require("milli").load({ splash = "shadertwo" })
            local version = vim.version()
            local version_str = string.format("  v%d.%d.%d", version.major, version.minor, version.patch)
            local date_str = "  " .. os.date("%A %d %B %Y")

            return {
                theme = "doom",
                config = {
                    header = splash.frames[1],
                    center = {
                        {
                            icon = "  ",
                            desc = "Fichiers récents",
                            key = "r",
                            action = "Telescope oldfiles",
                        },
                        {
                            icon = "  ",
                            desc = "Chercher un fichier",
                            key = "f",
                            action = "Telescope find_files",
                        },
                        {
                            icon = "  ",
                            desc = "Restaurer la session",
                            key = "s",
                            action = function() require("persistence").load() end,
                        },
                        {
                            icon = "  ",
                            desc = "Lazy",
                            key = "l",
                            action = "Lazy",
                        },
                        {
                            icon = "  ",
                            desc = "Mason",
                            key = "m",
                            action = "Mason",
                        },
                        {
                            icon = "  ",
                            desc = "Quitter",
                            key = "q",
                            action = "qa",
                        },
                    },
                    footer = { date_str, version_str },
                },
            }
        end,
        config = function(_, opts)
            require("dashboard").setup(opts)
            require("milli").dashboard({ splash = "shadertwo", loop = true })
        end,
    },
}
