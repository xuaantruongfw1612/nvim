return {
	"Eandrju/cellular-automaton.nvim",
	keys = {
		-- Make it rain!
		{
			"<leader>fml",
			"<cmd>CellularAutomaton make_it_rain<CR>",
			desc = "Make it rain",
		},
		-- Game of Life
		{
			"<leader>gol",
			"<cmd>CellularAutomaton game_of_life<CR>",
			desc = "Game of Life",
		},
		-- Scramble
		{
			"<leader>scr",
			"<cmd>CellularAutomaton scramble<CR>",
			desc = "Scramble text",
		},
	},
}

