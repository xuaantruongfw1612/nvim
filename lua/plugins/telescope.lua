return {
	-- Plugin chính: Telescope để tìm kiếm và duyệt file
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8", -- bạn có thể dùng bản mới hơn nếu muốn
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			-- 🔍 Các keymap tìm kiếm thường dùng
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {}) -- Tìm tất cả file
			vim.keymap.set("n", "<leader>pf", builtin.git_files, {}) -- Tìm file đã theo dõi bởi Git
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {}) -- Tìm từ khóa trong toàn bộ project
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {}) -- Danh sách buffer đang mở
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {}) -- Tìm kiếm trong tài liệu của Neovim

			-- 🧩 Các chức năng Git tích hợp với Telescope
			vim.keymap.set("n", "<leader>gs", builtin.git_status, {}) -- Giống `git status`, hiển thị file thay đổi
			vim.keymap.set("n", "<leader>gc", builtin.git_commits, {}) -- Danh sách tất cả commit trong repo
			vim.keymap.set("n", "<leader>gfc", builtin.git_bcommits, {}) -- Danh sách commit của file hiện tại
			vim.keymap.set("n", "<leader>gb", builtin.git_branches, {}) -- Danh sách branch, có thể checkout
			vim.keymap.set("n", "<leader>gS", builtin.git_stash, {}) -- Danh sách stash nếu có dùng
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

	-- (Tuỳ chọn) Hiển thị dấu git (+/-/~) bên lề file
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
}
