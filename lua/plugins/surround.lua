return {
	-- Plugin thêm/xoá/thay thế ký tự bao quanh (surround) nhanh chóng
	"kunkka19xx/simple-surr",

	config = function()
		-- Gọi hàm setup để cấu hình plugin
		require("simple-surr").setup({
			keymaps = {
				-- Bao quanh vùng chọn bằng ký tự
				surround_selection = "<leader>s",

				-- Bao quanh từ hiện tại bằng ký tự
				surround_word = "<leader>sw",

				-- Xoá hoặc thay đổi ký tự bao quanh từ hiện tại
				remove_or_change_surround_word = "<leader>sr",

				-- Toggle (bật/tắt) hoặc thay đổi ký tự bao quanh vùng chọn
				toggle_or_change_surround_selection = "<leader>ts",
			},
		})
	end,
}
