return {
	-- Plugin chính: Telescope để tìm kiếm và duyệt file
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden", -- Tìm hidden files
					},
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
				pickers = {
					find_files = {
						hidden = true, -- Tìm hidden files
					},
					live_grep = {
						additional_args = { "--hidden" }, -- Tìm trong hidden files
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}), -- Giao diện dropdown đẹp
					},
				},
			})
			require("telescope").load_extension("ui-select")
			local builtin = require("telescope.builtin")

			-- FUNCTION HELPER: Kiểm tra có phải Git project không
			local function get_git_root()
				local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
				if vim.v.shell_error ~= 0 then
					return nil
				end
				return git_root
			end

			-- 🔍 Các keymap tìm kiếm thường dùng
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "terminal new" })
			vim.keymap.set("n", "<leader>pf", builtin.git_files, { desc = "tracked by Git" })
			-- download ripgrep = sudo apt install ripgrep
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "keywords all projects" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "buffer is open" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "search for documents Neovim" })

			-- 🧩 Các chức năng Git tích hợp với Telescope
			vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "git status" })
			vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "repo commit" })
			vim.keymap.set("n", "<leader>gfc", builtin.git_bcommits, { desc = "file commit" })
			vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "check branch" })
			-- vim.keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "stash list" })

			-- 🔎 Tìm chính xác từ dưới con trỏ với --word-regexp
			vim.keymap.set("n", "<leader>fw", function()
				builtin.live_grep({
					prompt_title = "Exact Word Search",
					search = vim.fn.expand("<cword>"),
					additional_args = function()
						return { "--word-regexp", "--hidden" }
					end,
				})
			end, { desc = "Find exact word under cursor" })

			-- 🚀 TÌM FILE TRONG GIT PROJECT (CHỈ HOẠT ĐỘNG TRONG GIT REPO)
			vim.keymap.set("n", "<leader>gp", function()
				local git_root = get_git_root()
				if not git_root then
					print("❌ Not inside a Git repository!")
					return
				end
				builtin.find_files({
					prompt_title = "📁 Find Files in Git Project (Hidden + Visible)",
					hidden = true,
					respect_gitignore = true,
					cwd = git_root, -- Tìm từ Git root thay vì getcwd()
				})
			end, { desc = "Find files in Git project (including hidden)" })

			-- 🚀 TÌM TỪ TRONG GIT PROJECT (CHỈ HOẠT ĐỘNG TRONG GIT REPO)
			vim.keymap.set("n", "<leader>gw", function()
				local git_root = get_git_root()
				if not git_root then
					print("❌ Not inside a Git repository!")
					return
				end
				builtin.live_grep({
					prompt_title = "🔍 Grep in Git Project (Hidden + Visible)",
					cwd = git_root, -- Tìm từ Git root
					additional_args = { "--hidden" },
				})
			end, { desc = "Grep in Git project files (including hidden)" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function() end,
	},
}
