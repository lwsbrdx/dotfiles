return {
	"Exafunction/windsurf.vim",
	config = function()
		vim.keymap.set("i", "<leader><c-\\>", function()
			return vim.fn["codeium#Complete"]()
		end, { expr = true, silent = true })
	end,
}
