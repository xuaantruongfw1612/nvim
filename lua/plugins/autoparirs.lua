return {
	-- Plugin tự động thêm cặp dấu
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- Plugin comment đơn giản, không cần cấu hình
	{
		-- gcc: comment
		-- gc + j, k, }, ...: cmt theo vùng
		-- gc (visual mode): tất cả đã chọn
		"tpope/vim-commentary",
	},
}
