return {
	"kunkka19xx/simple-surr",
	config = function()
		require("simple-surr").setup({
			keymaps = {
				surround_selection = "<leader>s",
				surround_word = "<leader>sw",
				remove_or_change_surround_word = "<leader>sr",
				toggle_or_change_surround_selection = "<leader>ts",
			},
		})
	end,
}
