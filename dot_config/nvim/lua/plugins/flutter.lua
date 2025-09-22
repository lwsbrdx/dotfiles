return {
    "akinsho/flutter-tools.nvim",
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
                    vim.keymap.set("n", "<leader>fr", "<cmd>FlutterRun<cr>", opts)
                    vim.keymap.set("n", "<leader>fq", "<cmd>FlutterQuit<cr>", opts)
                    vim.keymap.set("n", "<leader>fd", "<cmd>FlutterDevices<cr>", opts)
                    vim.keymap.set("n", "<leader>fo", "<cmd>FlutterOutlineToggle<cr>", opts)
                end,
            },
        })
    end,
}
