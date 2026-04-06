return {
    "lwsbrdx/make-runner.nvim",
    config = function ()
        require("make-runner").setup(
            {
                open_in = 'tab',
                use_telescope = true,
            }
        )
    end
}
