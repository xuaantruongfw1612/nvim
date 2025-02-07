return {
	{
		"williamboman/mason.nvim",
		-- NOTE: I comment it to install jdtls (java language server)
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.rust_analyzer.setup({})
		end,
	},
}
