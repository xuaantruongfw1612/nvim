-- Đảm bảo đã cài đặt 'tokyonight' và 'lualine'
require("tokyonight").setup({
  transparent = true, -- Bật chế độ trong suốt
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  }
})

require("lualine").setup({
  options = {
    theme = "tokyonight", -- Dùng theme Tokyonight cho Lualine
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  }
})

vim.opt.termguicolors = true  -- Bật hỗ trợ màu sắc tốt hơn
vim.cmd("colorscheme tokyonight") -- Áp dụng theme Tokyonight
