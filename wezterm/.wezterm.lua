local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.enable_tab_bar = false

config.window_background_opacity = 0.9

-- config image
local user_home = os.getenv("HOME")
config.window_background_image = user_home..'/.config/nvim/bg/bg.jpg'
config.window_background_image_hsb = {
    hue = 1.0,
    saturation = 0.7,
    brightness = 0.22,
}

return config
