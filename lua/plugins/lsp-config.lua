return {
	-- Plugin cấu hình ngôn ngữ LSP chính
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig") -- Load module lspconfig để cấu hình server LSP

			-- Cấu hình cho ngôn ngữ Lua
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- Khai báo biến "vim" là global (tránh báo lỗi khi dùng trong config Neovim)
						},
					},
				},
			})

			-- Cấu hình cho ngôn ngữ C/C++ sử dụng clangd
			lspconfig.clangd.setup({})

			-- Cấu hình cho Python sử dụng pyright
			--      lspconfig.pyright.setup({})

			-- Cấu hình cho Java sử dụng jdtls
			lspconfig.jdtls.setup({})
		end,
	},

	-- Plugin Mason: công cụ quản lý LSP server, DAP, Linters, Formatters
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- Cập nhật danh sách server khi plugin được build
		config = function()
			require("mason").setup() -- Khởi tạo Mason
		end,
	},

	-- Plugin kết nối giữa Mason và LSPConfig: tự động cấu hình LSP server được cài qua Mason
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", -- LSP cho Lua
					"clangd", -- LSP cho C/C++
					--"pyright", -- LSP cho Python
					"jdtls", -- LSP cho Java
				},
				automatic_installation = true, -- Tự động cài đặt các LSP chưa có
			})
		end,
	},
}
