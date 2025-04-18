vim.g.mapleader = " "
vim.g.autoformat = true

vim.o.termguicolors = true

vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.laststatus = 3
vim.opt.showtabline = 2

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

vim.cmd.colorscheme("catppuccin")

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<C-Right>", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-u>zz")
vim.keymap.set("n", "<C-j>", "<C-d>zz")
vim.keymap.set("n", "<leader>h", ":noh<CR>", { silent = true })
vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], { noremap = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
        vim.schedule(function()
            vim.api.nvim_buf_set_option(0, "modified", false)
        end)
    end,
})
