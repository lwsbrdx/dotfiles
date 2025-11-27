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
            }

            -- Configuration spécifique pour emmet_ls
            vim.lsp.config.emmet_ls = {
                filetypes = {
                    "html",
                    "css",
                    "scss",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "vue",
                    "svelte",
                },
            }

            -- Ajouter les capabilities de nvim-cmp
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Configuration pour ts_ls (TS/JS + support Vue en arrière-plan)
            vim.lsp.config.ts_ls = {
                capabilities = capabilities,
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                            languages = { "vue" },
                        },
                    },
                },
            }

            -- Configuration pour vue_ls (gère Vue + TypeScript dans .vue)
            vim.lsp.config.vue_ls = {
                capabilities = capabilities,
                filetypes = { "vue" },
            }

            -- Setup de chaque serveur avec la nouvelle API
            for _, lsp in ipairs(servers) do
                if lsp ~= "emmet_ls" then
                    vim.lsp.config[lsp] = { capabilities = capabilities }
                else
                    vim.lsp.config[lsp].capabilities = capabilities
                end
                vim.lsp.enable(lsp)
            end

            -- Activer ts_ls et vue_ls (capabilities déjà configurées plus haut)
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("vue_ls")

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
                    "superhtml",
                    "emmet_ls",
                    "cssls",
                    -- Pour Vue.js: installer manuellement avec :MasonInstall vue-language-server
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
