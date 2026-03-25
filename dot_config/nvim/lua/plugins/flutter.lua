return {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim", -- optionnel (UI améliorée)
    },
    config = function()
        require("flutter-tools").setup({
            flutter_path = vim.fn.exepath("flutter"), -- auto-détecte ton binaire flutter
            widget_guides = { enabled = true },
            debugger = {            -- intègre nvim-dap
                enabled = true,
                run_via_dap = true, -- on passe par nvim-dap
            },
            lsp = {
                color = { enabled = true },
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterRun<cr>", { buffer = bufnr, silent = true, desc = "Flutter: lancer l'app" })
                    vim.keymap.set("n", "<leader>Fq", "<cmd>FlutterQuit<cr>", { buffer = bufnr, silent = true, desc = "Flutter: quitter l'app" })
                    vim.keymap.set("n", "<leader>Fd", "<cmd>FlutterDevices<cr>", { buffer = bufnr, silent = true, desc = "Flutter: liste des appareils" })
                    vim.keymap.set("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", { buffer = bufnr, silent = true, desc = "Flutter: afficher/masquer l'outline" })
                end,
            },
        })
    end,
}
