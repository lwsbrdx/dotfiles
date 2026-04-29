vim.g.mapleader = " "
vim.g.editorconfig = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 3

-- Indentation : 4 espaces
vim.opt.tabstop = 4       -- largeur d’une tabulation
vim.opt.shiftwidth = 4    -- indentation automatique
vim.opt.expandtab = true  -- utilise des espaces au lieu des tabulations
vim.opt.smartindent = true -- indentation intelligente

-- Themes
vim.opt.termguicolors = true

-- Global Keymaps
vim.keymap.set("n", "<leader>h", ":nohl<CR>", { desc = "Effacer la surbrillance de recherche" })
vim.keymap.set("n", "<leader>e", "<Cmd>e .<CR>", { desc = "Ouvrir le répertoire courant" })
vim.keymap.set("n", "<C-Left>", ":bp<CR>", { desc = "Buffer précédent" })
vim.keymap.set("n", "<C-Right>", ":bn<CR>", { desc = "Buffer suivant" })
