return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>v", ":Neotree filesystem reveal left<CR>", {})
		vim.keymap.set("n", "<leader>xx", ":Neotree filesystem close<CR>", {})

		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",

			default_component_configs = {
				git_status = {
					symbols = {
						added = "+",
						modified = "~",
						deleted = "x",
						renamed = "→",
						untracked = "?",
						ignored = "◌",
						unstaged = "!",
						staged = "✓",
						conflict = "⚔",
					},
				},
			},
		})
	end,
}
