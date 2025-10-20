-- sudo npm install -g prettier để format code
return {
	"nvimtools/none-ls.nvim",

	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			debug = false,
			sources = {
				null_ls.builtins.formatting.stylua.with({
					extra_args = { "--indent-width", "4" },
				}),

				null_ls.builtins.formatting.clang_format.with({
					extra_args = { "-style={IndentWidth: 4}" },
				}),

				-- Định dạng các file như JS, TS, HTML, CSS, v.v... bằng Prettier
				null_ls.builtins.formatting.prettier.with({
					extra_args = { "--tab-width", "4", "--use-tabs", "false" },
				}),

				-- Định dạng Python import tự động theo chuẩn bằng isort
				null_ls.builtins.formatting.isort,

				-- Kiểm tra lỗi kiểu dữ liệu trong Python bằng mypy
				null_ls.builtins.diagnostics.mypy,
			},
		})

		if vim.lsp.buf ~= nil then
			vim.keymap.set("n", "<leader>gf", function()
				vim.lsp.buf.format({

					filter = function(client)
						return client.name == "null-ls"
					end,

					timeout_ms = 3000,
				})
			end, { desc = "Format the code using null-ls" })
		end
	end,
}
