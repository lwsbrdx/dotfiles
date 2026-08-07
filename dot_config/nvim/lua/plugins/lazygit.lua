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
    end,
}
