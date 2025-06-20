-- Preview markdown
return {
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_browser = "chrome" -- hoặc "microsoft-edge:"
		end,
	},
}
