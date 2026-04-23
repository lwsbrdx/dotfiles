return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = "BufReadPre",
    build = ":TSUpdate",
    config = function()
      vim.filetype.add({
        pattern = {
          ["%.env"]     = "dotenv",
          ["%.env%..+"] = "dotenv",
        },
      })

      require("nvim-treesitter").setup({})
    end,
  }
}
