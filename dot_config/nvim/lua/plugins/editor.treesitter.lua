return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"javascript",
					"html",
					"go",
					"rust",
					"php",
				},
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		{
			"RRethy/nvim-treesitter-endwise",
			event = "BufEnter",
			config = function()
				require("nvim-treesitter.configs").setup({
					endwise = {
						enable = true,
					},
				})
			end,
		},
	},
}
