return {
	{
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
					width = 0.2, -- rộng 20% cửa sổ
				},
			})

			vim.keymap.set("n", "<leader>v", ":Neotree filesystem reveal left<CR>", { desc = "Open Neo-tree sidebar" })
			vim.keymap.set("n", "<leader>xx", ":Neotree filesystem close<CR>", { desc = "Close Neo-tree sidebar" })
		end,
	},

	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},

	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },  
		event = "VimEnter",
		config = function()
			require("config.ui")
		end,
	},
}

