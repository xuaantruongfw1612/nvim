-- Cấu hình plugin
return {
	"lazymaniac/wttr.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",  -- Dành cho việc xử lý công việc bất đồng bộ
		"MunifTanjim/nui.nvim",   -- Dành cho việc tạo popup và cửa sổ UI
	},
	opts = {
		city = "Hanoi",  -- Chọn thành phố bạn muốn xem thời tiết
		custom_format = "%t", -- Định dạng thông tin thời tiết
	},
	config = function(_, opts)
		-- Cấu hình và thiết lập plugin sau khi được tải
		local wttr = require("wttr")
		wttr.setup(opts)

		local api = vim.api
		local buf, win

		-- Tạo cửa sổ nổi để hiển thị thời tiết
		local function create_floating_win()
			if win and api.nvim_win_is_valid(win) then
				return -- Nếu cửa sổ đã tồn tại thì không tạo mới
			end
			buf = api.nvim_create_buf(false, true) -- Tạo buffer ẩn
		end

		-- Cập nhật cửa sổ với thông tin thời tiết
		local function update_weather_display()
			local forecast = wttr.text or "Không thể lấy thông tin thời tiết" -- Xử lý nếu không lấy được thời tiết

			-- Tạo cửa sổ nổi nếu chưa có
			create_floating_win()

			-- Thiết lập chiều rộng và chiều cao của cửa sổ
			local win_width = #forecast + 9
			local max_width = vim.o.columns - 10 -- Giới hạn chiều rộng cửa sổ
			if win_width > max_width then
				win_width = max_width
			end

			-- Các tùy chọn cấu hình cửa sổ nổi
			local opts = {
				relative = "editor",
				width = win_width,
				height = 1, -- Chỉ có 1 dòng
				row = vim.o.lines - 2, -- Hiển thị ở dòng cuối cùng
				col = 75, -- Cách mép trái
				style = "minimal",
				border = "none",
			}

			-- Nếu cửa sổ chưa tồn tại, tạo mới
			if not win or not api.nvim_win_is_valid(win) then
				win = api.nvim_open_win(buf, false, opts)
			else
				-- Nếu cửa sổ đã tồn tại, cập nhật lại kích thước và vị trí
				api.nvim_win_set_config(win, opts)
			end

			-- Cập nhật nội dung của cửa sổ nổi với thông tin thời tiết
			api.nvim_buf_set_lines(buf, 0, -1, false, { "Weather: " .. forecast })
		end

		-- Lệnh để hiển thị thời tiết
		vim.api.nvim_create_user_command("Weather", function()
			update_weather_display()
		end, {})
	end
}
