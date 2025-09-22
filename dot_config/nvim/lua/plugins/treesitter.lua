return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function ()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "json", "javascript", "typescript", "python", "php", "java", "rust", "go" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  }
}
