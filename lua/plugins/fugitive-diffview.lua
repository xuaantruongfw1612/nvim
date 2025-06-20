return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gread", "Glog" },
		keys = {
			{ "<leader>g.", "<cmd>Git<CR>", desc = "Fugitive status" },
			{ "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff current file" },
			{ "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
		},
	},

	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		keys = {
			{ "<leader>dv", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
			{ "<leader>dc", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
			{ "<leader>df", "<cmd>DiffviewToggleFiles<CR>", desc = "Toggle file panel" },
		},
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true,
				view = {
					merge_tool = {
						layout = "diff3_mixed",
						disable_diagnostics = true,
					},
				},
			})
		end,
	},
}
