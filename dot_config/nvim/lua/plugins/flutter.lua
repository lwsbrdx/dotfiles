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
                    local opts = { buffer = bufnr, silent = true }
                    vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterRun<cr>", opts)
                    vim.keymap.set("n", "<leader>Fq", "<cmd>FlutterQuit<cr>", opts)
                    vim.keymap.set("n", "<leader>Fd", "<cmd>FlutterDevices<cr>", opts)
                    vim.keymap.set("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", opts)
                end,
            },
        })
    end,
}
