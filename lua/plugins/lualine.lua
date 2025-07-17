return {
	-- 🌙 Giao diện (theme) Tokyonight với style "moon"
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Load đầu tiên để đảm bảo theme áp dụng sớm
		config = function()
			require("tokyonight").setup({
				style = "moon", -- Chọn kiểu "moon", có thể đổi sang "storm", "night", v.v.
				transparent = true, -- Làm nền trong suốt
				terminal_colors = true, -- Đồng bộ màu terminal trong Neovim
			})
			vim.cmd("colorscheme tokyonight") -- Áp dụng giao diện
		end,
	},

	-- ⏱ Thanh trạng thái lualine với màu theme tokyonight
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "folke/tokyonight.nvim" }, -- Dùng theme cùng tokyonight
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight", -- Lấy màu từ theme
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

	-- 🔲 Plugin làm trong suốt toàn bộ UI (kể cả lualine)
	{
		"xiyaowong/transparent.nvim",
		lazy = false, -- Load ngay lập tức
		priority = 999, -- Load sau theme (vì priority thấp hơn 1000)
		config = function()
			require("transparent").setup({
				enable = true, -- Bật chế độ trong suốt
				extra_groups = {
					"Normal",
					"NormalNC",
					"EndOfBuffer",
					"Lualine", -- Các group được làm trong
				},
			})
		end,
	},
}
-- │        
