-- Lưu trạng thái của cửa sổ và buffer cho cửa sổ nổi
local state = { floating = { buf = -1, win = -1 } }

-- Hàm tạo cửa sổ nổi với các tùy chọn
local function create_floating_window(opts)
	-- Kiểm tra các tùy chọn và sử dụng mặc định nếu không có
	opts = opts or {}

	-- Tính toán kích thước cửa sổ dựa trên kích thước của Neovim
	local width = math.floor(vim.o.columns * 0.8) -- Chiều rộng cửa sổ (80% màn hình)
	local height = math.floor(vim.o.lines * 0.8) -- Chiều cao cửa sổ (80% màn hình)

	-- Vị trí cửa sổ (căn giữa màn hình)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Kiểm tra xem buffer có hợp lệ hay không, nếu không sẽ tạo mới
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		-- Tạo một buffer mới không có tên (không liên kết với file)
		buf = vim.api.nvim_create_buf(false, true)
	end

	-- Cấu hình cho cửa sổ nổi (floating window)
	local config = {
		relative = "editor", -- Cửa sổ nổi căn cứ vào cửa sổ editor hiện tại
		width = width, -- Chiều rộng cửa sổ
		height = height, -- Chiều cao cửa sổ
		row = row, -- Vị trí hàng (căn giữa)
		col = col, -- Vị trí cột (căn giữa)
		style = "minimal", -- Cửa sổ với kiểu "minimal" (không có các yếu tố giao diện dư thừa)
		border = "rounded", -- Border cửa sổ là dạng "rounded" (bo tròn)
	}

	-- Tạo highlight cho cửa sổ nổi
	vim.api.nvim_set_hl(0, "MyFloatingWindow", { bg = "#1e1e1e", fg = "#ffffff", blend = 10 })

	-- Mở cửa sổ nổi và trả về cả buffer và window
	local win = vim.api.nvim_open_win(buf, true, config)
	return { buf = buf, win = win }
end

-- Hàm toggle (bật/tắt) cửa sổ terminal nổi
local toggle_term = function()
	-- Nếu cửa sổ terminal nổi không hợp lệ (chưa mở), tạo cửa sổ mới
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		-- Tạo cửa sổ mới và lưu lại buffer và window
		state.floating = create_floating_window({ buf = state.floating.buf })

		-- Nếu buffer không phải terminal, chạy lệnh terminal
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal() -- Mở terminal trong cửa sổ
		end
	else
		-- Nếu cửa sổ đã mở, ẩn nó đi
		vim.api.nvim_win_hide(state.floating.win)
	end
end

-- Tạo lệnh người dùng "FTerm" để bật/tắt cửa sổ terminal nổi
vim.api.nvim_create_user_command("FTerm", toggle_term, {})

-- <leader>T toggle_term trong chế độ normal và terminal
vim.keymap.set({ "n", "t" }, "<leader>T", toggle_term, { desc = "terminal new)" })
