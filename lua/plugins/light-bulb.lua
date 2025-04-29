-- Khi bạn đặt con trỏ vào lỗi / cảnh báo,
-- VSCode thường có cái bóng đèn 💡 hiện ra → nhấn vào để quick fix / import, v.v.
-- Plugin này mô phỏng y chang trong nvim

return {
	"kosayoda/nvim-lightbulb",
	config = function()
		-- Tắt hiển thị tự động
		require("nvim-lightbulb").setup({
			autocmd = { enabled = true }, -- tự động bật lightbulb khi có action code
		})

		-- Khôi phục trạng thái từ vim.g nếu có
		local lightbulb_shown = vim.g.lightbulb_shown or false

		-- Gán phím để bật/tắt lightbulb thủ công
		vim.keymap.set("n", "<leader>lb", function()
			if lightbulb_shown then
				-- Nếu lightbulb đã hiển thị, tắt nó
				require("nvim-lightbulb").update_lightbulb()
				vim.notify("Đã tắt lightbulb", vim.log.levels.INFO)
				lightbulb_shown = false
				vim.g.lightbulb_shown = false -- Lưu trạng thái tắt vào vim.g
			else
				-- Nếu lightbulb chưa hiển thị, bật nó
				require("nvim-lightbulb").update_lightbulb()
				vim.notify("Đã bật lightbulb", vim.log.levels.INFO)
				lightbulb_shown = true
				vim.g.lightbulb_shown = true -- Lưu trạng thái bật vào vim.g
			end
		end, { desc = "Bật/Tắt lightbulb" })
	end,
}
