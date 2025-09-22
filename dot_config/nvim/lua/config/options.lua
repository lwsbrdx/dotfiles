vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 8

-- Indentation : 4 espaces
vim.opt.tabstop = 4       -- largeur d’une tabulation
vim.opt.shiftwidth = 4    -- indentation automatique
vim.opt.expandtab = true  -- utilise des espaces au lieu des tabulations
vim.opt.smartindent = true -- indentation intelligente

-- Themes
vim.opt.termguicolors = true

-- Global Keymaps
vim.keymap.set("n", "<leader>h", ":nohl<CR>")
vim.keymap.set("n", "<leader>e", "<Cmd>e .<CR>")
vim.keymap.set("n", "<leader>x", "<Cmd>Ex<CR>")
vim.keymap.set("n", "<C-Left>", ":bp<CR>")
vim.keymap.set("n", "<C-Right>", ":bn<CR>")
