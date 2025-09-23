return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local builtin = require('telescope.builtin')

            -- Files
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope recent files' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

            -- LSP
            vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'LSP references' })
            vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = 'LSP implementations' })
            vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'LSP definitions' })
            vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "LSP rename symbol" })
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code actions" })
            vim.keymap.set(
                'n', '<leader>le',
                function()
                    builtin.diagnostics({ bufnr = 0 })
                end,
                { desc = 'Lists Diagnostics for current buffer (bufnr=0)' }
            )
            vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols,
                { desc = 'Lists LSP document symbols in the current buffer' })

            -- Git
            vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits diff view' })
            vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'List git branches' })
            vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })

            -- Vim
            vim.keymap.set('n', '<leader>vr', builtin.registers, { desc = 'Vim registers and paste the selected' })
            vim.keymap.set('n', '<leader>vj', builtin.jumplist, { desc = 'Vim jumplist' })
            vim.keymap.set('n', '<leader>vm', builtin.jumplist, { desc = 'Vim marklist' })
            vim.keymap.set('n', '<leader>vk', builtin.keymaps, { desc = 'List of keymaps' })

        end
    }
}
