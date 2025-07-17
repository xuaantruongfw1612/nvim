return {
	"xuantruong1612/fast-run",
	config = function()
		require("fast-run").setup({
			enable = { "c", "python", "cpp", "java", "html" },
		})
	end,
}
