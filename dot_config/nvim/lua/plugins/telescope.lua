return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    layout_strategy = "vertical",
                    layout_config = {
                        vertical = {
                            prompt_position = "bottom",
                            preview_height = 0.75,
                            width = 0.9,
                            height = 0.95,
                            mirror = false,  -- preview en haut, résultats en bas
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true
                    }
                }
            })

            local builtin = require('telescope.builtin')

            -- Files
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope recent files' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

            -- Git
            vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits diff view' })
            vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'List git branches' })
            vim.keymap.set('n', '<leader>gS', builtin.git_status, { desc = 'Git status' })

            -- Vim
            vim.keymap.set('n', '<leader>vr', builtin.registers, { desc = 'Vim registers and paste the selected' })
            vim.keymap.set('n', '<leader>vj', builtin.jumplist, { desc = 'Vim jumplist' })
            vim.keymap.set('n', '<leader>vm', builtin.marks, { desc = 'Vim marklist' })
            vim.keymap.set('n', '<leader>vk', builtin.keymaps, { desc = 'List of keymaps' })
        end
    }
}
