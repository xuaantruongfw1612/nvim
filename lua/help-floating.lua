-- Tạo một autocmd để tự động thực thi khi mở file loại "help"
vim.api.nvim_create_autocmd("FileType", {
	-- Chỉ áp dụng cho file loại "help"
	pattern = "help",

	callback = function()
		-- Lấy buffer hiện tại đang mở (trong trường hợp này là buffer của help)
		local crbuf = vim.api.nvim_get_current_buf()

		-- Đóng cửa sổ hiện tại (cửa sổ help)
		vim.cmd("wincmd c")

		-- Mở lại buffer help trong một cửa sổ mới với kích thước và vị trí được cấu hình
		vim.api.nvim_open_win(crbuf, true, {
			-- Cửa sổ nổi sẽ được căn cứ vào cửa sổ editor hiện tại
			relative = "editor",

			-- Kích thước cửa sổ: chiếm 60% chiều rộng và chiều cao màn hình
			width = math.floor(vim.o.columns * 0.6),
			height = math.floor(vim.o.lines * 0.6),

			-- Vị trí cửa sổ: căn giữa màn hình, với khoảng cách 20% từ trên và trái
			col = math.floor(vim.o.columns * 0.2),
			row = math.floor(vim.o.lines * 0.2),

			-- Border cửa sổ là bo tròn
			border = "rounded",
		})
	end,
})
