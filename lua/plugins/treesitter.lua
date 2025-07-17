return {
	-- Plugin chính: nvim-treesitter - hỗ trợ highlight, indent, folding,... theo cấu trúc ngôn ngữ
	"nvim-treesitter/nvim-treesitter",

	build = ":TSUpdate",

	config = function()
		local config = require("nvim-treesitter.configs")

		config.setup({
			auto_install = true,

			-- Ngôn ngữ cần parser
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"python",
				"java",
				"javascript",
				"bash",
				"json",
				"html",
				"css",
				"markdown",
				"rust",
			},

			sync_install = false,

			-- Highlight theo cấu trúc ngôn ngữ
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			-- Tự động indent theo block
			indent = {
				enable = true,
			},

			-- Bật fold (mặc dù fold thực tế sẽ được điều khiển bởi vim.opt)
			fold = {
				enable = true,
			},
		})

		-- ⚙️ Thiết lập folding với treesitter
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldenable = true
		vim.opt.foldlevel = 99 -- Mở hết khi vào file

		-- 🎨 Tùy chỉnh highlight
		vim.api.nvim_set_hl(0, "@comment", { fg = "#808080" })           -- Comment xám
		vim.api.nvim_set_hl(0, "@variable", { fg = "#F5F5F5" })          -- Biến thường
		vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#F5F5F5" })  -- Biến có sẵn
		vim.api.nvim_set_hl(0, "@keyword", { fg = "#FFFFFF" })           -- Từ khóa (if, return,...)
	end,
}
