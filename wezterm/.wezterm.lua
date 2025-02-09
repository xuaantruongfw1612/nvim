local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.enable_tab_bar = false
config.window_background_opacity = 0.8

config.window_background_image_hsb = {
    brightness = 0.05,
    hue = 1.0,
    saturation = 0.7,
}

-- config image
local user_home = os.getenv("HOME")
local background_folder = user_home .. "/.config/nvim/bg"

-- Ngẫu nhiên một ảnh từ thư mục
local function pick_random_background(folder)
    local handle = io.popen('ls "' .. folder .. '"')
    local files = handle:read("*a")
    handle:close()

    local images = {}
    for file in string.gmatch(files, "[^\n]+") do
        table.insert(images, file)
    end

    if #images > 0 then
        local random_file = folder .. "/" .. images[math.random(#images)]
        wezterm.log_info("Selected random background: " .. random_file)
        return random_file
    else
        wezterm.log_error("No images found in folder: " .. folder)
        return nil
    end
end

-- Ảnh nền ngẫu nhiên khi WezTerm khởi động
wezterm.on("window-created", function(window, pane)
    local new_background = pick_random_background(background_folder)
    if new_background then
        window:set_config_overrides({
            window_background_image = new_background,
        })
        wezterm.log_info("New bg on startup: " .. new_background)
    else
        wezterm.log_error("Could not set bg on startup")
    end
end)

-- Phím tắt
config.keys = {
    {
        key = "b",
        mods = "CTRL|SHIFT",
        action = wezterm.action_callback(function(window, pane)
            local new_background = pick_random_background(background_folder)
            if new_background then
                -- Thay đổi ảnh nền ngay khi nhấn tổ hợp phím
                window:perform_action(wezterm.action({SetBackgroundImage = new_background}), pane)
                wezterm.log_info("New bg on key press: " .. new_background)
            else
                wezterm.log_error("Could not find bg image")
            end
        end),
    },
}

return config
