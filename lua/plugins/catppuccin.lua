return {
	-- Plugin giao diện (theme) "catppuccin"
	"catppuccin/nvim",

	-- Đặt tên alias cho plugin (dùng trong các cấu hình khác nếu cần)
	name = "catppuccin",

	-- Độ ưu tiên cao nhất (đảm bảo theme được load sớm)
	priority = 1000,

	-- Hàm cấu hình plugin
	config = function()
		-- Áp dụng màu giao diện catppuccin
		vim.cmd.colorscheme("catppuccin")
	end,
}
