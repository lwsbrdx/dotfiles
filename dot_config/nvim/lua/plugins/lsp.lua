return {
    -- nvim-lspconfig : configuration des LSP
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            -- local lspconfig = vim.lsp.config

            -- Liste des LSP que tu veux utiliser
            local servers = {
                "lua_ls",
                "ts_ls",
                "pyright",
                "gopls",
                "rust_analyzer",
                "intelephense",
            }
            -- Setup de chaque serveur
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup({})
            end

            -- KeyBindings
            vim.keymap.set("n", "<leader>lf", function()
                vim.lsp.buf.format({ async = true })
            end, { desc = "Format buffer with LSP" })
        end,
    },

    -- Mason : interface pour installer LSP, DAP et formatters
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason-LSPConfig : connecte Mason avec nvim-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "pyright",
                    "gopls",
                    "rust_analyzer",
                    "intelephense",
                },
                automatic_installation = true, -- installe automatiquement si absent
            })
        end,
    },

    -- nvim-jdtls : gestion Java (LSP + DAP + tests)
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
    },
}
