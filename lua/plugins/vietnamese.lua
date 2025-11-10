return {
	"xuaantruongfw1612/vietnamese-nvim",
	event = "InsertEnter",
	config = function()
		local vn = require("vietnamese")
		vn.setup()
		vim.cmd("VietnameseToggle")
		vim.api.nvim_set_keymap("n", "<leader>l", "<Esc>:VietnameseToggle<CR>", { noremap = true, silent = true })
	end,
}
