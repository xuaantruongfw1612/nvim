local M = {}

vim.keymap.set("n", "<leader>t", function()
    vim.cmd("w")

    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    local cmd

if filetype == "c" then
    vim.cmd("vertical rightbelow vsplit")
    vim.cmd("vertical resize 50")
    cmd = 'term gcc -o "%:r" "%" && ./"%:r"'
elseif filetype == "cpp" then
    vim.cmd("vertical rightbelow vsplit")
    vim.cmd("vertical resize 50")
    cmd = 'term g++ -o "%:r" "%" && ./"%:r"'
elseif filetype == "python" then
    vim.cmd("vertical rightbelow vsplit")
    vim.cmd("vertical resize 50")
    cmd = 'term python3 "%"'
elseif filetype == "java" then
    vim.cmd("vertical rightbelow vsplit")
    vim.cmd("vertical resize 50")
    cmd = 'term javac "%" && java "%:r"'
else
    print("No support file =))")
    return
end

    vim.cmd(cmd)
    vim.cmd("startinsert") -- insert

    -- keymap for terminal
	vim.api.nvim_buf_set_keymap(0, "n", "<CR>", ":q<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "t", "<Up>", "<C-\\><C-n><Up>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "t", "<Down>", "<C-\\><C-n><Down>", { noremap = true, silent = true })
end, { noremap = true, silent = true })

return M
