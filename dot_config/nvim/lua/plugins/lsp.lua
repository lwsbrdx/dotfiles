return {
    -- nvim-lspconfig : configuration des LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            vim.diagnostic.config({
                update_in_insert = true,
            })

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
            local vue_language_server_path = vim.fn.stdpath("data") ..
                "/mason/packages/vue-language-server/node_modules/@vue/language-server"
            -- Configuration spécifique lua_ls
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            -- Configuration spécifique ts_ls avec support Vue
            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                cmd = { mason_bin .. "/typescript-language-server", "--stdio" },
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                init_options = {
                    hostInfo = "neovim",
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vue_language_server_path,
                            languages = { "vue" },
                            configNamespace = "typescript",
                        },
                    },
                },
            })

            -- Configuration spécifique vue_ls
            vim.lsp.config('vue_ls', {
                capabilities = capabilities,
                cmd = { mason_bin .. "/vue-language-server", "--stdio" },
            })

            -- Configuration spécifique rust_analyzer
            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = true,
                        check = {
                            command = "clippy",
                        },
                        diagnostics = {
                            enable = true,
                        },
                    },
                },
            })

            -- Configuration spécifique emmet_ls
            vim.lsp.config("emmet_ls", {
                capabilities = capabilities,
                filetypes = {
                    "html", "css", "scss",
                    "javascript", "javascriptreact",
                    "typescript", "typescriptreact",
                    "vue", "svelte",
                },
            })

            -- Setup des serveurs sans config spécifique
            local simple_servers = { "pyright", "gopls", "intelephense", "superhtml", "cssls" }
            for _, server in ipairs(simple_servers) do
                vim.lsp.config(server, { capabilities = capabilities })
                vim.lsp.enable(server)
            end

            -- Enable les serveurs déjà configurés spécifiquement
            for _, server in ipairs({ "lua_ls", "ts_ls", "vue_ls", "rust_analyzer", "emmet_ls" }) do
                vim.lsp.enable(server)
            end

            -- KeyBindings
            vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end,
                { desc = "Format buffer with LSP" })
            vim.keymap.set("n", "<leader>ll", function() vim.diagnostic.open_float() end,
                { desc = "Diagnostic float" })
            vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP hover" })
            vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "LSP rename symbol" })
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code actions" })

            local ok, builtin = pcall(require, "telescope.builtin")
            if not ok then
                vim.notify("Telescope non disponible : keymaps LSP limités", vim.log.levels.WARN)
                return
            end

            vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "LSP references" })
            vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, { desc = "LSP implementations" })
            vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, { desc = "LSP definitions" })
            vim.keymap.set("n", "<leader>le", function()
                builtin.diagnostics({ bufnr = 0 })
            end, { desc = "LSP diagnostics (buffer)" })
            vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols,
                { desc = "LSP document symbols" })
        end,
    },

    -- Mason : pour installer les serveurs LSP
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },

    -- mason-lspconfig : installation automatique des serveurs LSP
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "pyright",
                    "gopls",
                    "rust_analyzer",
                    "intelephense",
                    "emmet_ls",
                    "cssls",
                    "vue_ls",
                },
            })
        end,
    },

    -- nvim-jdtls : gestion Java (LSP + DAP + tests)
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
    },
}
