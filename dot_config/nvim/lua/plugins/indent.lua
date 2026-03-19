return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        main = "ibl",
        opts = {
            indent = { char = "│" }, -- caractère pour l’indent
            scope = { enabled = true }, -- met en valeur le bloc courant
        },
    },
}
