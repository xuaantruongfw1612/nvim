return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {
				width = 0.2, -- 20%
			},
		})

		vim.keymap.set("n", "<leader>v", ":Neotree filesystem reveal left<CR>", {})
		vim.keymap.set("n", "<leader>xx", ":Neotree filesystem close<CR>", {})
	end,
}
