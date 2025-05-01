local M = {}

M.config = {
	-- Cấu hình các phím đặc biệt và cách chúng hiển thị
	special_keys = {
		["\t"] = "⇥", -- Tab
		["\n"] = "⏎", -- Enter
		[" "] = "␣", -- Space
		["\27"] = "⎋", -- Esc
	},

	-- Tối đa số phím được hiển thị
	max_keys_display = 20,

	-- Các thông số về cửa sổ nổi
	window = {
		width_padding = 10, -- Giới hạn tối đa chiều rộng của cửa sổ nổi
		row_offset = 3, -- Vị trí hiển thị cửa sổ (dòng cuối cùng)
		col_offset = 5, -- Vị trí cách mép trái
	},
}

return M
