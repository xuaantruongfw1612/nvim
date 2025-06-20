return {

	-- Git inside Vim
	{
		"tpope/vim-fugitive",
		cmd = { "Git" },
	},

	-- Single tabpage interface for easily cycling through diffs for all modified
	-- files for any git rev.
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFileHistory" },
		config = function()
			require("config.diffview")
		end,
	},

	-- Git integration for buffers
	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		opts = {
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "╎" },
			},
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				delay = 500,
			},
			current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d> - <summary>",
			numhl = true,
			watch_gitdir = {
				interval = 100,
			},
			sign_priority = 0,
			status_formatter = nil, -- Use default
		},
	},

	{
		"tiagovla/scope.nvim",
		opts = {},
		event = "User FilePost",
	},

	-- vim dadbod
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_icons = {
				expanded = {
					db = "  ",
					tables = " ﴳ",
					table = " ﴳ",
					buffers = "  ",
					saved_queries = "  ",
					schemas = "  ",
					schema = "  ",
				},
				collapsed = {
					db = "  ",
					tables = " ﴳ",
					table = " ﴳ",
					buffers = "  ",
					saved_queries = "  ",
					schemas = "  ",
					schema = "  ",
				},
				new_query = "",
				tables = "ﴳ",
				saved_query = " ",
				buffers = " ",
				connection_ok = "✓",
				connection_error = "✕",
			}
		end,
	},
}
