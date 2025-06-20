return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local actions = require("diffview.config").actions

		require("diffview").setup({
			diff_binaries = false,
			use_icons = true,
			view = {
				merge_tool = {
					layout = "diff3_horizontal",
					disable_diagnostics = true,
				},
			},
			file_panel = {
				win_config = {
					position = "left",
					width = 35,
					height = 10,
				},
			},
			keymaps = {
				disable_defaults = false,
				view = {
					{ "n", "<leader>n", actions.toggle_files, { desc = "Bật/tắt file panel" } },
					{ "n", "<leader>q", "<cmd>DiffviewClose<CR>", { desc = "Đóng Diffview" } },
					{ "n", "<leader>e", false },
					{ "n", "<Space>e", false },
				},
				file_panel = {
					{ "n", "<leader>n", actions.toggle_files, { desc = "Bật/tắt file panel" } },
					{ "n", "t", actions.listing_style, { desc = "Chuyển giữa list/tree" } },
					{ "n", "<cr>", actions.select_entry, { desc = "Mở file diff" } },
					{ "n", "<leader>q", "<cmd>DiffviewClose<CR>", { desc = "Đóng Diffview" } },
					{ "n", "<leader>e", false },
					{ "n", "<Space>e", false },
				},
				panel = {
					{ "n", "<leader>q", "<cmd>DiffviewClose<CR>", { desc = "Đóng Diffview" } },
				},
				file_history_panel = {
					{ "n", "<leader>n", actions.toggle_files, { desc = "Bật/tắt file panel" } },
					{ "n", "<leader>q", "<cmd>DiffviewClose<CR>", { desc = "Đóng Diffview" } },
					{ "n", "<leader>e", false },
					{ "n", "<Space>e", false },
				},
			},
		})
	end,
}
