return {
	-- Plugin giúp làm trong suốt nền của Neovim
	"xiyaowong/transparent.nvim",

	config = function()
		-- Thiết lập cấu hình cho plugin transparent
		require("transparent").setup({
			-- Bật tính năng trong suốt
			enable = true,

			-- Danh sách các nhóm cần làm trong suốt
			extra_groups = {
				"Normal",           -- Nền cửa sổ chính
				"NormalNC",         -- Nền cửa sổ không focus
				"TelescopeBorder",  -- Nền cho Telescope Border
				"NvimTreeNormal",   -- Nền cho NvimTree (file explorer)
				"LualineNormal",    -- Nền cho Lualine (status line)
			},
		})

		-- Xóa trong suốt cho các nhóm liên quan đến NeoTree
		require("transparent").clear_prefix("NeoTree")

		-- Xóa trong suốt cho các nhóm liên quan đến Lualine
		require("transparent").clear_prefix("lualine")

		-- Cấu hình các màu sắc nền để rõ ràng và trong suốt
		-- Xóa màu nền của Normal (nền chính)
		vim.cmd("highlight Normal guibg=NONE")
		-- Xóa màu nền của Lualine
		vim.cmd("highlight Lualine guibg=NONE")
		vim.cmd("highlight Lualine guifg=NONE")
		-- Xóa màu nền của cửa sổ không focus (NormalNC)
		vim.cmd("highlight NormalNC guibg=NONE")
		--Xóa màu nền của CursorLine (dòng hiện tại)
		vim.cmd("highlight CursorLine guibg=NONE")
	end,
}
