return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitLog",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    init = function()
        -- Force lazygit à utiliser notre config custom, quel que soit le
        -- dossier de config par défaut de l'OS (Application Support sur macOS).
        vim.g.lazygit_use_custom_config_file_path = 1
        vim.g.lazygit_config_file_path = vim.fn.expand("~/.config/lazygit/config.yml")

        -- Appelée par ~/.config/lazygit/config.yml (os.edit / os.editAtLine)
        -- via `nvim --server $NVIM --remote-send`. Ferme la fenêtre flottante
        -- de lazygit puis rejoint l'onglet où le fichier est déjà ouvert s'il
        -- existe, sinon en ouvre un nouveau.
        vim.api.nvim_create_user_command("LazygitEdit", function(opts)
            local line, parts = nil, {}
            for _, arg in ipairs(opts.fargs) do
                local n = arg:match("^%+(%d+)$")
                if n then
                    line = tonumber(n)
                else
                    table.insert(parts, arg)
                end
            end
            local filename = vim.fn.fnamemodify(table.concat(parts, " "), ":p")

            local win = vim.api.nvim_get_current_win()
            if vim.api.nvim_win_get_config(win).relative ~= "" then
                vim.api.nvim_win_close(win, false)
            end

            local bufnr = vim.fn.bufnr(filename)
            if bufnr ~= -1 then
                local wins = vim.fn.win_findbuf(bufnr)
                if #wins > 0 then
                    vim.api.nvim_set_current_win(wins[1])
                else
                    vim.cmd.tabnew()
                    vim.api.nvim_win_set_buf(0, bufnr)
                end
            else
                vim.cmd.tabnew(vim.fn.fnameescape(filename))
            end

            if line then
                pcall(vim.api.nvim_win_set_cursor, 0, { line, 0 })
            end
        end, { nargs = "+", complete = "file" })
    end,
}
