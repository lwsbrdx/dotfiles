-- Chemin où Lazy.nvim sera installé
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Vérifie si le dossier existe
if not vim.loop.fs_stat(lazypath) then
	-- Si pas présent, clone le dépôt stable
	vim.fn.system({
		"git", "clone",
		"--filter=blob:none",                   -- économise la taille
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",                      -- branche stable
		lazypath,
	})
end

-- Ajoute Lazy.nvim au runtime path pour qu'il soit utilisable
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	}
})

