return {
	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty",
			processor = "magick_cli",
			integrations = {
				markdown = {
					enabled = true,
					only_render_image_at_cursor = true,
					only_render_image_at_cursor_mode = "popup",
				},
			},
			max_height_window_percentage = 80,
		},
	},
}
