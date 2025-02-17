local M = {}

vim.keymap.set("n", "<leader>t", function()
	vim.cmd("w")

	local filetype = vim.api.nvim_buf_get_option(0, "filetype")
	local cmd

	if filetype == "c" then
		cmd = 'split | term gcc -o "%:r" "%" && ./"%:r"'
	elseif filetype == "cpp" then
		cmd = 'split | terminal g++ -o "%:r" "%" && ./"%:r"'
	elseif filetype == "python" then
		cmd = 'split | term python3 "%"'
	elseif filetype == "java" then
		cmd = 'split | term javac "%" && java "%:r"'
	else
		print("Không hỗ trợ biên dịch cho loại tệp này.")
		return
	end

	vim.cmd(cmd)
	vim.cmd("startinsert") -- Insert mode
end, { noremap = true, silent = true })

return M
