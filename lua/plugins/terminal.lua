local M = {}

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


return M
