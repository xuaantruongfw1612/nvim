return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8", -- có thể chọn phiên bản khác
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- use telescope'
			local builtin = require("telescope.builtin")
			-- tìm file (find files)
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			-- tìm file trong git (project files)
			vim.keymap.set("n", "<leader>pf", builtin.git_files, {})
			-- tìm từ khóa trong tất cả file (live grep)
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			-- danh sách các buffer đang mở
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			-- tìm kiếm trong tài liệu help của Neovim
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				defaults = {
					layout_config = {
						horizontal = {
							preview_width = 0.6,
							width = 0.85,
						},
						vertical = {
							preview_height = 0.6,
							height = 0.85,
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
