-- return {
-- 	"lazymaniac/wttr.nvim",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim", -- Xử lý bất đồng bộ
-- 		"MunifTanjim/nui.nvim", -- UI popup
-- 	},
-- 	opts = {
-- 		city = "@21.0285,105.8542", -- Vị trí: trung tâm Hà Nội
-- 		custom_format = "%C%20%c%t%20🌡️", -- Định dạng hiển thị
-- 	},
-- 	config = function(_, opts)
-- 		local wttr = require("wttr")
-- 		wttr.setup(opts)

-- 		local api = vim.api
-- 		local buf, win

-- 		local function create_floating_win()
-- 			if win and api.nvim_win_is_valid(win) then
-- 				return
-- 			end
-- 			buf = api.nvim_create_buf(false, true)
-- 		end

-- 		local function update_weather_display()
-- 			local forecast = wttr.text or "Không thể lấy thông tin thời tiết"
-- 			create_floating_win()

-- 			local win_width = #forecast - 5
-- 			local max_width = vim.o.columns - 10
-- 			if win_width > max_width then
-- 				win_width = max_width
-- 			end

-- 			local opts = {
-- 				relative = "editor",
-- 				width = win_width,
-- 				height = 1,
-- 				row = vim.o.lines - 2,
-- 				col = 75,
-- 				style = "minimal",
-- 				border = "none",
-- 			}

-- 			if not win or not api.nvim_win_is_valid(win) then
-- 				win = api.nvim_open_win(buf, false, opts)
-- 			else
-- 				api.nvim_win_set_config(win, opts)
-- 			end

-- 			api.nvim_buf_set_lines(buf, 0, -1, false, { forecast })
-- 		end

-- 		-- Lệnh thủ công để hiển thị thời tiết
-- 		api.nvim_create_user_command("Weather", update_weather_display, {})

-- 		-- Tự động hiển thị sau 2 giây khi mở Neovim
-- 		api.nvim_create_autocmd("VimEnter", {
-- 			callback = function()
-- 				vim.defer_fn(update_weather_display, 2000)

-- 				-- Tự động cập nhật lại mỗi 5 phút (300000 ms)
-- 				vim.fn.timer_start(5 * 60 * 1000, function()
-- 					update_weather_display()
-- 				end, { ["repeat"] = -1 })
-- 			end,
-- 		})
-- 	end,
-- }

