return {
	-- Plugin tự động thêm cặp dấu (như (), {}, "", ''...)
	"windwp/nvim-autopairs",

	-- Cấu hình plugin sau khi tải
	config = function()
		-- Gọi và thiết lập plugin với cấu hình mặc định
		require("nvim-autopairs").setup({})
	end,
}
