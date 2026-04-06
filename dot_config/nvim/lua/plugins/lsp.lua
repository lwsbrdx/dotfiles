return {
    -- nvim-lspconfig : configuration des LSP
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Liste des LSP à utiliser
            local servers = {
                "lua_ls",
                "pyright",
                "gopls",
                "rust_analyzer",
                "intelephense",
                "superhtml",
                "emmet_ls",
                "cssls",
                "vue_ls",
            }

            vim.diagnostic.config({
                update_in_insert = true,
            })

            -- Ajouter les capabilities de nvim-cmp
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Setup de chaque serveur avec la nouvelle API
            for _, lsp in ipairs(servers) do
                vim.lsp.config[lsp] = vim.lsp.config[lsp] or {}
                vim.lsp.config[lsp].capabilities = capabilities
                vim.lsp.enable(lsp)
            end

            vim.lsp.config.lua_ls.settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file('', true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            }

            -- Configuration spécifique pour emmet_ls
            vim.lsp.config.emmet_ls.filetypes = {
                "html",
                "css",
                "scss",
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
                "svelte",
            }

            -- Configuration pour ts_ls (TS/JS + support Vue en arrière-plan)
            -- hostInfo doit être explicite pour ne pas être écrasé par les defaults nvim-lspconfig
            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                init_options = {
                    hostInfo = "neovim",
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vim.fn.stdpath("data") ..
                                "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                            languages = { "vue" },
                        },
                    },
                },
            })

            -- Configuration pour rust_analyzer (affiche les warnings clippy)
            vim.lsp.config.rust_analyzer.settings = {
                ["rust-analyzer"] = {
                    checkOnSave = true,
                    check = {
                        command = "clippy",
                    },
                    diagnostics = {
                        enable = true,
                    },
                },
            }

            -- Activer ts_ls uniquement (vue_ls est dans le loop servers)
            vim.lsp.enable("ts_ls")

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

    -- Mason : interface pour installer LSP, DAP et formatters
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
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
                    "superhtml",
                    "emmet_ls",
                    "cssls",
                    "vue-language-server",
                },
                automatic_installation = true,
                handlers = {
                    -- Empêche mason-lspconfig d'auto-activer vtsls et vuels
                    vtsls = function() end,
                    vuels = function() end,
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
