-- Tất cả các hàm hỗ trợ cho nvim ở đây

-- Chuyển nội dung diagnostic (thông báo lỗi) tại vị trí con trỏ vào clipboard
vim.keymap.set("n", "<leader>ce", function()
	-- Lấy thông báo lỗi tại dòng con trỏ đang đứng
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })

	-- Nếu có lỗi, copy thông báo lỗi vào clipboard
	if #diagnostics > 0 then
		local message = diagnostics[1].message  -- Lấy thông báo lỗi đầu tiên
		vim.fn.setreg("+", message)             -- Đặt thông báo lỗi vào clipboard của Neovim
		print("Copied diagnostic: " .. message) -- In thông báo đã copy
	else
		-- Nếu không có lỗi tại con trỏ, in thông báo
		print("No diagnostic at cursor")
	end
end, { noremap = true, silent = true })

-- Chuyển đến lỗi tiếp theo trong file
vim.keymap.set("n", "<leader>ne", vim.diagnostic.goto_next) -- Tiếp theo
-- Chuyển đến lỗi trước đó trong file
vim.keymap.set("n", "<leader>pe", vim.diagnostic.goto_prev) -- Trước đó
-- Mở lỗi dưới dạng cửa sổ nổi (floating window) ngay tại vị trí con trỏ
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

-- Copy đường dẫn tuyệt đối của file hiện tại vào clipboard
vim.keymap.set("n", "<leader>cp", function()
	-- Lấy đường dẫn tuyệt đối của file hiện tại
	local filepath = vim.fn.expand("%:p")

	-- Đặt đường dẫn vào clipboard của Neovim
	vim.fn.setreg("+", filepath)

	-- Copy đường dẫn vào clipboard hệ thống (macOS sử dụng pbcopy)
	vim.fn.system("echo '" .. filepath .. "' | pbcopy")

	-- In thông báo đã copy đường dẫn
	print("Copied: " .. filepath)
end, { desc = "Copy absolute path to clipboard" })

-- Mở file hiện tại bằng trình duyệt (mặc định là Microsoft Edge)
vim.keymap.set("n", "<leader>ob", function()
    local file_path = vim.fn.expand("%:p") -- Lấy đường dẫn tuyệt đối Linux
    if file_path ~= "" then
        local cmd
        -- Nếu đang chạy trong WSL
        if vim.fn.has("wsl") == 1 then
            -- Chuyển đường dẫn Linux sang Windows path (dùng wslpath)
            local windows_path = vim.fn.system({ "wslpath", "-w", file_path }):gsub("\n", "")
            -- Mở bằng Microsoft Edge (cài sẵn trên Windows)
            cmd = 'cmd.exe /C start microsoft-edge:"' .. windows_path .. '"'
        elseif vim.fn.has("mac") == 1 then
            -- macOS
            cmd = "open -a 'Microsoft Edge' '" .. file_path .. "'"
        else
            -- Linux thuần
            cmd = "xdg-open '" .. file_path .. "'"
        end
        os.execute(cmd .. " &")
    else
        print("No file to open")
    end
end, { desc = "Open current file in Edge" })
