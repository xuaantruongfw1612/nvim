return {
	-- 📁 Telescope file browser (duyệt file kiểu GUI trong popup)
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").load_extension("file_browser")
			vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<CR>", { desc = "File Browser" })
		end,
	},

	-- 🎨 Devicons: Hiện icon file đẹp
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},
}
