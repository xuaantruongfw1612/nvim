return {
	"uga-rosa/ccc.nvim",
	config = function()
		local ccc = require("ccc")
		ccc.setup()

		vim.keymap.set({ "n", "v" }, "<leader>cc", function()
			vim.cmd("CccPick")
		end, { noremap = true, silent = true })

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
			callback = function()
				vim.cmd("CccHighlighterEnable")
			end,
		})
	end,
}
