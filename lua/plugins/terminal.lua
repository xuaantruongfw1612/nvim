local M = {}

vim.keymap.set("n", "<leader>t", function()
    vim.cmd("w") -- Lưu file

    local filetype = vim.bo.filetype
    local fullpath = vim.fn.expand("%:p")      -- Đường dẫn tuyệt đối file
    local dir = vim.fn.expand("%:p:h")         -- Thư mục chứa file
    local filename_noext = vim.fn.expand("%:t:r") -- Tên file không có đuôi

    local output_path = string.format("%s/%s", dir, filename_noext)
    local cmd

    vim.cmd("vertical rightbelow vsplit")
    vim.cmd("vertical resize 50")

    if filetype == "c" then
        cmd = string.format('term gcc -o "%s" "%s" -lm -lpthread -ldl -lrt && "%s"', output_path, fullpath, output_path)
    elseif filetype == "cpp" then
        cmd = string.format('term g++ -o "%s" "%s" && "%s"', output_path, fullpath, output_path)
    elseif filetype == "python" then
        cmd = string.format('term python3 "%s"', fullpath)
    elseif filetype == "java" then
        cmd = string.format('term javac "%s" && cd "%s" && java "%s"', fullpath, dir, filename_noext)
    elseif filetype == "javascript" or filetype == "js" then
        cmd = string.format('term node "%s"', fullpath)
    else
        print("No support file =))")
        return
    end

    vim.cmd(cmd)
    vim.cmd("startinsert")

    -- Keymap trong terminal
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", ":q<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "t", "<Up>", "<C-\\><C-n><Up>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "t", "<Down>", "<C-\\><C-n><Down>", { noremap = true, silent = true })
end, { noremap = true, silent = true })

return M
