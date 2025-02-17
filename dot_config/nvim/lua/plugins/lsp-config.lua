return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "rust_analyzer",
                    "intelephense",
                    "ts_ls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local cap = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = cap,
            })
            lspconfig.gopls.setup({
                capabilities = cap,
            })
            lspconfig.rust_analyzer.setup({
                capabilities = cap,
            })
            lspconfig.intelephense.setup({
                capabilities = cap,
            })
            lspconfig.ts_ls.setup({
                capabilities = cap
            })


            vim.keymap.set("n", "H", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
            vim.keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, {})
        end,
    },
}
