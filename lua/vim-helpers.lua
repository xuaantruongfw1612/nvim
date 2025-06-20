-- Tất cả các hàm hỗ trợ cho nvim ở đây

-- Chuyển nội dung diagnostic (thông báo lỗi) tại vị trí con trỏ vào clipboard
vim.keymap.set("n", "<leader>ce", function()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })

	if #diagnostics > 0 then
		local message = diagnostics[1].message
		vim.fn.setreg("+", message)
		print("✅ Copied diagnostic: " .. message)
	else
		print("ℹ️ No diagnostic at cursor")
	end
end, { noremap = true, silent = true, desc = "Copy diagnostic at cursor" })

-- diagnostic
vim.keymap.set("n", "<leader>ne", vim.diagnostic.goto_next, {
	desc = "Go to next error",
})
vim.keymap.set("n", "<leader>pe", vim.diagnostic.goto_prev, {
	desc = "Go to previous error",
})
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
	desc = "Show error message (float)",
})

-- Copy path file hiện tại vào clipboard
vim.keymap.set("n", "<leader>cp", function()
	local filepath = vim.fn.expand("%:p")
	vim.fn.setreg("+", filepath)
	vim.fn.system("echo '" .. filepath .. "' | pbcopy")
	print("Copied: " .. filepath)
end, { desc = "Copy absolute path to clipboard" })
