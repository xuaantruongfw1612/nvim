return {
	-- Plugin chính: nvim-treesitter - hỗ trợ highlight, indent, folding,... theo cấu trúc ngôn ngữ
	"nvim-treesitter/nvim-treesitter",

	build = ":TSUpdate",

	config = function()
		local config = require("nvim-treesitter.configs")

		config.setup({
			auto_install = true,

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
			},

			sync_install = false,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		})
		-- Tùy chỉnh màu sắc highlight
		-- Comment: màu xám (#808080)
		vim.api.nvim_set_hl(0, "@comment", { fg = "#808080" })
		-- Biến: màu xanh lá (#00FF00)
		vim.api.nvim_set_hl(0, "@variable", { fg = "#00FF00" })
		vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#00FF00" })
		-- Từ khóa (return, function, local,...): màu trắng (#FFFFFF)
		vim.api.nvim_set_hl(0, "@keyword", { fg = "#FFFFFF" })
	end,
}
