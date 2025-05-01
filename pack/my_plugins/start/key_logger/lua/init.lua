local key_logger = require("key_logger.key_logger")

vim.on_key(function(key)
	key_logger.on_key_press(key)
end, api.nvim_create_namespace("key_logger"))
