local M = {}
-- Thiết lập phím <leader>t để chạy file đang mở theo loại file (filetype)
vim.keymap.set("n", "<leader>t", function()
	vim.cmd("w") -- Lưu file trước khi chạy

	local filetype = vim.api.nvim_buf_get_option(0, "filetype") -- Lấy loại file của buffer hiện tại
	local cmd

	-- Nếu là file C
	if filetype == "c" then
		vim.cmd("vertical rightbelow vsplit") -- Mở cửa sổ terminal bên phải
		vim.cmd("vertical resize 50") -- Đặt chiều rộng là 50 ký tự
		-- Biên dịch bằng gcc và chạy file đầu ra
		cmd = 'term gcc -o "%:r" "%" -lm -lpthread -ldl -lrt && ./"%:r"'

	-- Nếu là file C++
	elseif filetype == "cpp" then
		vim.cmd("vertical rightbelow vsplit")
		vim.cmd("vertical resize 50")
		cmd = 'term g++ -o "%:r" "%" && ./"%:r"'

	-- Nếu là file Python
	elseif filetype == "python" then
		vim.cmd("vertical rightbelow vsplit")
		vim.cmd("vertical resize 50")
		cmd = 'term python3 "%"'

	-- Nếu là file Java
	elseif filetype == "java" then
		vim.cmd("vertical rightbelow vsplit")
		vim.cmd("vertical resize 50")
		-- Biên dịch bằng javac và chạy class
		cmd = 'term javac "%" && java "%:r"'

	-- Nếu là file JavaScript
	elseif filetype == "javascript" or filetype == "js" then
		vim.cmd("vertical rightbelow vsplit")
		vim.cmd("vertical resize 50")
		-- Chạy bằng node.js
		cmd = 'term node "%"'

	-- Nếu không phải file được hỗ trợ
	else
		print("No support file =))")
		return
	end

	-- Thực thi lệnh đã thiết lập ở trên
	vim.cmd(cmd)
	vim.cmd("startinsert") -- Tự động vào chế độ insert để tương tác trong terminal

	-- Thiết lập phím tắt cho terminal buffer hiện tại:

	-- Nhấn Enter ở chế độ Normal để thoát terminal
	vim.api.nvim_buf_set_keymap(0, "n", "<CR>", ":q<CR>", { noremap = true, silent = true })

	-- Trong chế độ Terminal, dùng mũi tên để thoát terminal mode rồi di chuyển
	vim.api.nvim_buf_set_keymap(0, "t", "<Up>", "<C-\\><C-n><Up>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "t", "<Down>", "<C-\\><C-n><Down>", { noremap = true, silent = true })
end, { noremap = true, silent = true })

return M
