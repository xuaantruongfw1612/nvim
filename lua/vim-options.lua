vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
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
vim.opt.colorcolumn = "90"

-- print code
vim.keymap.set('n', '<leader>t', function()
  local filetype = vim.bo.filetype
  local cmd

  if filetype == 'c' or filetype == 'cpp' then
    cmd = 'split | term gcc % -o %< && ./%<'
  elseif filetype == 'python' then
    cmd = 'split | term python3 %'
  elseif filetype == 'java' then
    cmd = 'split | term javac % && java %<'
  else
    print("Không hỗ trợ biên dịch cho loại tệp này.")
    return
  end

  vim.cmd(cmd)
  vim.cmd("startinsert")  -- Chuyển vào Insert Mode
end, { noremap = true, silent = true })

