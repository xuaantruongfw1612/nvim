local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.on("gui-startup", function()
	wezterm.log_info("CONFIG BY XUAN TRUONG")
    wezterm.log_info("CTRL + SHIFT + b: Đổi Background")
    wezterm.log_info("https://www.facebook.com/serayeuem")
end)

-- Tùy chỉnh giao diện
config.enable_tab_bar = false
config.initial_cols = 100
config.initial_rows = 25
config.window_background_image_hsb = {
	brightness = 0.05,
	hue = 1.0,
	saturation = 0.7,
}

-- Lấy thư mục hình nền
local user_home = os.getenv("USERPROFILE")
local background_folder = user_home .. "\\wezterm\\bg"

-- Lấy danh sách ảnh nền
local function get_background_images(folder)
	local handle = io.popen('dir /b "' .. folder .. '"')
	if not handle then
		return {}
	end

	local files = handle:read("*a")
	handle:close()

	local images = {}
	for file in string.gmatch(files, "[^\r\n]+") do
		table.insert(images, folder .. "\\" .. file)
	end
	return images
end

-- Lấy tên file từ đường dẫn
local function get_filename(path)
	return string.match(path, "[^\\]+$")
end

-- Danh sách và ảnh nền ban đầu
local images = get_background_images(background_folder)
table.sort(images)
local image_index = 1

local function get_next_background()
	if #images == 0 then
		return nil
	end
	local background = images[image_index]
	image_index = (image_index % #images) + 1
	return background
end

-- Thiết lập ảnh nền ngẫu nhiên khi khởi động
if #images > 0 then
	math.randomseed(os.time())
	config.window_background_image = images[math.random(#images)]
else
	wezterm.log_error("Không tìm thấy hình nền để thiết lập khi khởi động")
end

-- Phím Ctrl+Shift+B để đổi hình nền
config.keys = {
	{
		key = "b",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			local new_background = get_next_background()
			if new_background then
				window:set_config_overrides({
					window_background_image = new_background,
				})
				wezterm.log_info("XUAN TRUONG - Background: - " .. get_filename(new_background))
			else
				wezterm.log_error("Không thể tìm thấy hình nền")
			end
		end),
	},
}

-- Font và shell mặc định
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Light" })
config.font_size = 14.0
config.default_prog = { "powershell.exe", "-NoLogo" }

return config
