vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4") -- <CR>, >>, <<
vim.g.mapleader = " "
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "white" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ead84e" })
vim.api.nvim_set_option("clipboard", "unnamed")
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- paste over highlight word
vim.keymap.set("x", "<leader>p", '"_dP')
--vim.opt.colorcolumn = "90"
vim.keymap.set("n", "<leader>m", [[:%s/\r//g | w<CR>]], { desc = "Xóa ^M và lưu file" })
-- P: Dán từ clipboard hệ thống vào nvim (paste ngoài vào)
vim.keymap.set("n", "P", '"+p') -- Normal mode
vim.keymap.set("v", "P", '"+p') -- Visual mode

-- Y: Sao chép từ nvim ra clipboard hệ thống (copy ra ngoài)
vim.keymap.set("n", "Y", '"+y$') -- Copy từ con trỏ đến hết dòng
vim.keymap.set("v", "Y", '"+y') -- Copy đoạn đang chọn
