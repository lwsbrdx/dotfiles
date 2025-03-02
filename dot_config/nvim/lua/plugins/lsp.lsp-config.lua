return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"rust_analyzer",
					"intelephense",
					"ts_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local cap = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace", -- Complétion améliorée pour les `setup()`
						},
						diagnostics = {
							globals = { "vim" }, -- Évite les erreurs sur `vim`
						},
					},
				},
				capabilities = cap,
			})
			lspconfig.gopls.setup({
				capabilities = cap,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = cap,
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "check",
						},
						diagnostics = {
							enable = true,
						},
					},
				},
			})
			lspconfig.intelephense.setup({
				capabilities = cap,
			})
			lspconfig.ts_ls.setup({
				capabilities = cap,
			})
			lspconfig.dartls.setup({
				cmd = { "dart", "language-server", "--protocol=lsp" },
				capabilities = cap,
				settings = {
					lineLength = 120,
				},
			})

			vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, {})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.diagnostics.phpcs.with({
						command = "phpcs",
						args = { "--standard=PSR12", "-" },
					}),
					null_ls.builtins.diagnostics.phpstan,
				},
			})

			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
