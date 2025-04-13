-- Cấu hình tab và indent
vim.cmd("set expandtab") -- Thay thế tab bằng space khi gõ (không dùng ký tự tab)
vim.cmd("set tabstop=4") -- Số lượng spaces để biểu thị một tab
vim.cmd("set softtabstop=4") -- Số lượng spaces khi ấn Tab trong chế độ insert
vim.cmd("set shiftwidth=4") -- Đặt số lượng spaces khi sử dụng >>, << trong chế độ normal

-- Đặt leader key thành space
vim.g.mapleader = " "

-- Hiển thị số dòng
vim.cmd("set number") -- Hiển thị số dòng tuyệt đối
vim.cmd("set relativenumber") -- Hiển thị số dòng tương đối
vim.cmd("set cursorline") -- Làm nổi bật dòng hiện tại

-- Thiết lập màu sắc cho các dòng trên và dưới dòng hiện tại
-- Màu chữ của các dòng trên dòng hiện tại
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "white" })
-- Màu chữ của các dòng dưới dòng hiện tại
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ead84e" })
 -- Cho phép sử dụng clipboard hệ thống
vim.cmd("set clipboard=unnamed")
-- Tìm kiếm
vim.opt.hlsearch = true -- Làm nổi bật các kết quả tìm kiếm
vim.opt.incsearch = true -- Tìm kiếm trực tiếp khi gõ

-- Di chuyển các dòng được chọn lên hoặc xuống
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Di chuyển đoạn văn bản đã chọn xuống
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Di chuyển đoạn văn bản đã chọn lên

-- Dán vào vị trí đã chọn mà không ghi đè lên lựa chọn
vim.keymap.set("x", "<leader>p", '"_dP')

-- Xóa dấu ^M (carriage return) và lưu file
vim.keymap.set("n", "<leader>m", [[:%s/\r//g | w<CR>]], { desc = "Xóa ^M và lưu file" })

-- P: Dán từ clipboard hệ thống vào nvim (paste ngoài vào)
vim.keymap.set("n", "P", '"+p') -- Dán ở normal mode
vim.keymap.set("v", "P", '"+p') -- Dán ở visual mode

-- Y: Sao chép từ nvim ra clipboard hệ thống (copy ra ngoài)
vim.keymap.set("n", "Y", '"+y$') -- Sao chép từ con trỏ đến hết dòng
vim.keymap.set("v", "Y", '"+y') -- Sao chép đoạn văn bản đang chọn
