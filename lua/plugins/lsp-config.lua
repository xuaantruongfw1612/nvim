return {
	-- Plugin cấu hình ngôn ngữ LSP chính
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Cấu hình cho Lua
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			-- Cấu hình cho C/C++
			lspconfig.clangd.setup({})

			-- Cấu hình cho Java
			lspconfig.jdtls.setup({})

			-- ✅ Cấu hình cho Rust
			lspconfig.rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			})
		end,
	},

	-- Plugin quản lý LSP server, formatter, linter,...
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	-- Kết nối Mason và LSPConfig
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"jdtls",
				},
				automatic_installation = true,
			})
		end,
	},
}
