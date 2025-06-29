return {
	-- Plugin chính: Telescope để tìm kiếm và duyệt file
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			-- 🔍 Các keymap tìm kiếm thường dùng
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "terminal new" })
			vim.keymap.set("n", "<leader>pf", builtin.git_files, { desc = "tracked by Git" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "keywords all projects" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "buffer is open" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "search for documents Neovim" })

			-- 🧩 Các chức năng Git tích hợp với Telescope
			vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "git status" })
			vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "repo commit" })
			vim.keymap.set("n", "<leader>gfc", builtin.git_bcommits, { desc = "file commit" })
			-- vim.keymap.set("n", "<leader>gb", builtin.git_branches, {desc = "check branch"})
			-- vim.keymap.set("n", "<leader>gS", builtin.git_stash, {desc = "stash list"})
		end,
	},

	-- Extension giúp chọn UI kiểu dropdown (rất tiện)
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
						require("telescope.themes").get_dropdown({}), -- Giao diện dropdown đẹp
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
