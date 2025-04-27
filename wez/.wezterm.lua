local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.enable_kitty_keyboard = false

config.font_size = 12.5
config.line_height = 1.2

config.enable_tab_bar = false
config.initial_cols = 105
config.initial_rows = 25
config.window_background_image_hsb = {
	brightness = 0.05,
	hue = 1.0,
	saturation = 0.7,
}

local user_home = os.getenv("USERPROFILE")
local background_folder = user_home .. "\\wezterm\\bg"

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

-- NOTES
local function notes_filename()
	local date = wezterm.strftime("%Hh_%d%m%Y")
	return string.format("nvim C:\\Users\\%s\\Documents\\git\\scratch\\notes\\note_%s.md", os.getenv("USERNAME"), date)
end

-- Set background lúc khởi động
if #images > 0 then
	math.randomseed(os.time())
	config.window_background_image = images[math.random(#images)]
	wezterm.log_info("Đã thiết lập hình nền ban đầu: " .. config.window_background_image)
else
	wezterm.log_error("Không tìm thấy hình nền để thiết lập khi khởi động")
end

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	{
		key = "b",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local new_background = get_next_background()
			if new_background then
				window:set_config_overrides({
					window_background_image = new_background,
				})
				wezterm.log_info("Hình nền mới: " .. new_background)
			else
				wezterm.log_error("Không thể tìm thấy hình nền")
			end
		end),
	},

	{ key = "j", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
	{ key = "k", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "h", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "l", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	-- Gọi file Notes
	{
		key = "e",
		mods = "CTRL",
		action = wezterm.action.SplitPane({
			direction = "Right",
			command = { args = { "cmd.exe", "/C", notes_filename() } },
		}),
	},
}

return config
