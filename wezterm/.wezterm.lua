local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.enable_tab_bar = false
config.initial_cols = 100  -- rộng
config.initial_rows = 27   -- cao

config.window_background_opacity = 0.9
config.window_background_image_hsb = {
    brightness = 0.05,
    hue = 1.0,
    saturation = 0.7,
}

local user_home = os.getenv("HOME")
local background_folder = user_home .. "/.config/nvim/bg"

local function get_background_images(folder)
    local handle = io.popen('ls -1 "' .. folder .. '"')
    local files = handle:read("*a")
    handle:close()
    
    local images = {}
    for file in string.gmatch(files, "[^\n]+") do
        table.insert(images, folder .. "/" .. file)
    end
    return images
end

local images = get_background_images(background_folder)
local image_index = 1

local function get_next_background()
    if #images == 0 then
        return nil
    end
    local background = images[image_index]
    image_index = (image_index % #images) + 1
    return background
end

local initial_background = get_next_background()
if initial_background then
    config.window_background_image = initial_background
    wezterm.log_info("Đã thiết lập hình nền ban đầu: " .. initial_background)
else
    wezterm.log_error("Không tìm thấy hình nền để thiết lập khi khởi động")
end

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
                wezterm.log_info("Hình nền mới: " .. new_background)
            else
                wezterm.log_error("Không thể tìm thấy hình nền")
            end
        end),
    },
}

return config

