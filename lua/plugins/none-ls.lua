return {
	-- Plugin chính: none-ls (trước đây gọi là null-ls) - dùng để tích hợp formatter, linter dưới dạng LSP
	"nvimtools/none-ls.nvim",

	-- Phụ thuộc vào plenary.nvim (thư viện tiện ích cần thiết cho nhiều plugin)
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local null_ls = require("null-ls") -- Gọi thư viện null-ls (đã đổi tên thành none-ls)

		null_ls.setup({
			debug = false, -- Tắt chế độ debug (bật nếu bạn muốn kiểm tra lỗi khi thiết lập)
			sources = {
				-- Định dạng Lua code bằng stylua, với tuỳ chỉnh là indent = 4 spaces
				null_ls.builtins.formatting.stylua.with({
					extra_args = { "--indent-width", "4" },
				}),

				-- Định dạng C/C++ code bằng clang_format, indent = 4 spaces
				null_ls.builtins.formatting.clang_format.with({
					extra_args = { "-style={IndentWidth: 4}" },
				}),

				-- Định dạng các file như JS, TS, HTML, CSS, v.v... bằng Prettier
				null_ls.builtins.formatting.prettier.with({
					extra_args = { "--tab-width", "4", "--use-tabs", "false" }, -- indent = 4 spaces, không dùng tab
				}),

				-- Định dạng Python import tự động theo chuẩn bằng isort
				null_ls.builtins.formatting.isort,

				-- Kiểm tra lỗi kiểu dữ liệu trong Python bằng mypy
				null_ls.builtins.diagnostics.mypy,
			},
		})

		-- Kiểm tra xem LSP đã được kích hoạt chưa, nếu có thì map phím để format
		if vim.lsp.buf ~= nil then
			-- Gán phím <leader>gf để format code bằng LSP (sử dụng formatter từ none-ls)
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end
	end,
}
