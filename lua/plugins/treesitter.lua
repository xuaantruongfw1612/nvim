return {
	-- Plugin chính: nvim-treesitter - hỗ trợ highlight, indent, folding,... theo cấu trúc ngôn ngữ
	"nvim-treesitter/nvim-treesitter",

	-- Chạy lệnh :TSUpdate sau khi cài đặt để cập nhật parser
	build = ":TSUpdate",

	config = function()
		local config = require("nvim-treesitter.configs")

		config.setup({
			-- Tự động cài parser khi mở file nếu chưa có
			auto_install = true,

			-- Danh sách ngôn ngữ bạn muốn Treesitter hỗ trợ
			ensure_installed = {
				"c", -- Ngôn ngữ C
				"lua", -- Lua (Neovim config)
				"vim", -- Vim script
				"python", -- Python
				"java", -- Java
				"javascript", -- JavaScript ✔️ (mới thêm)
				"bash",
				"json",
				"html",
				"css",
				"markdown",
			},

			-- Không cài đồng bộ, tiết kiệm thời gian khi khởi động
			sync_install = false,

			-- Bật highlight code dựa trên cây cú pháp
			highlight = {
				enable = true,
			},

			-- Bật tự động indent code
			indent = {
				enable = true,
			},
		})
	end,
}
