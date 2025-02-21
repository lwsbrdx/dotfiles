return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local cyberdream = require("cyberdream")
		cyberdream.setup({
			transparent = false,
		})
		cyberdream.load()
		-- 🚀 Appliquer les couleurs après chargement du thème
		vim.schedule(function()
			vim.cmd([[
				highlight StatusLine guibg=#005f87 guifg=#ffffff
				highlight StatusLineNC guibg=#3a3a3a guifg=#aaaaaa
			]])
		end)
	end,
}
