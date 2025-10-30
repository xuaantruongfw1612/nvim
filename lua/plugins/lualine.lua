return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "moon", -- "moon", "storm", "night", ...
				transparent = true,
				terminal_colors = true,
			})
			vim.cmd("colorscheme tokyonight")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "folke/tokyonight.nvim" }, 
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight", 
					icons_enabled = true, -- icon
					component_separators = { left = "│", right = "│" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						"mode", -- Tự chuyển màu theo mode
					},
					lualine_b = {
						"branch",
						"diff",
						{
							"diagnostics",
							sources = { "nvim_diagnostic" }, -- lấy từ (LSP)
							sections = { "error", "warn", "info", "hint" },
							symbols = {
								error = " ", -- Lỗi
								warn = " ", -- Cảnh báo
								info = " ", -- Thông tin
								hint = " ", -- Gợi ý
							},
							colored = true, -- Mỗi loại sẽ có màu riêng
							update_in_insert = true, -- Cập nhật khi đang trong Insert
							always_visible = false, -- Luôn hiển thị
						},
					},
					lualine_c = { { "filename", path = 1 } },
					lualine_y = { "progress" }, -- Tiến trình cuộn file
					lualine_z = { "location" }, -- Vị trí dòng/cột
				},
			})
		end,
	},

	-- Plugin làm trong suốt toàn bộ UI (kể cả lualine)
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		priority = 999, 
		config = function()
			require("transparent").setup({
				enable = true,
				extra_groups = {
					"Normal",
					"NormalNC",
					"EndOfBuffer",
					"Lualine",
				},
			})
		end,
	},
}
-- │        
