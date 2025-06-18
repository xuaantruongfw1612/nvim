-- local M = {}
-- local api = vim.api
-- local buf, win

-- -- Cấu hình vị trí & định dạng
-- local city = "@21.0285,105.8542" -- Hà Nội
-- local custom_format = "%c%t%20🌡️" -- Định dạng hiển thị

-- -- Tạo buffer và window nếu chưa có
-- local function create_floating_win()
-- 	if win and api.nvim_win_is_valid(win) then
-- 		return
-- 	end
-- 	buf = api.nvim_create_buf(false, true)
-- end

-- -- Cập nhật & hiển thị dự báo thời tiết
-- local function update_weather_display()
-- 	local Job = require("plenary.job")

-- 	-- Lấy các giá trị cần thiết ngoài callback
-- 	local lines = vim.o.lines
-- 	local columns = vim.o.columns

-- 	create_floating_win()

-- 	Job:new({
-- 		command = "curl",
-- 		args = {
-- 			"-s",
-- 			string.format("https://wttr.in/%s?format=%s", city, custom_format),
-- 		},
-- 		on_exit = function(j, return_val)
-- 			local forecast = j:result()[1] or "Không thể lấy thông tin thời tiết"
-- 			local win_width = #forecast - 8
-- 			local max_width = columns - 10
-- 			if win_width > max_width then
-- 				win_width = max_width
-- 			end

-- 			-- Sử dụng vim.defer_fn để hoãn việc mở cửa sổ
-- 			vim.defer_fn(function()
-- 				local opts = {
-- 					relative = "editor",
-- 					width = win_width,
-- 					height = 1,
-- 					row = lines - 3,
-- 					col = columns - win_width - 1,
-- 					style = "minimal",
-- 					border = "none",
-- 				}

-- 				if not win or not api.nvim_win_is_valid(win) then
-- 					win = api.nvim_open_win(buf, false, opts)
-- 				else
-- 					api.nvim_win_set_config(win, opts)
-- 				end

-- 				api.nvim_buf_set_lines(buf, 0, -1, false, { forecast })
-- 			end, 10) -- Hoãn 10ms
-- 		end,
-- 	}):start()
-- end

-- -- Lệnh thủ công: :Weather
-- api.nvim_create_user_command("Weather", update_weather_display, {})

-- -- Tự động hiện khi vào Neovim và cập nhật 5 phút/lần
-- api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		vim.defer_fn(update_weather_display, 2000)

-- 		vim.fn.timer_start(5 * 60 * 1000, function()
-- 			update_weather_display()
-- 		end, { ["repeat"] = -1 })
-- 	end,
-- })

-- return M
