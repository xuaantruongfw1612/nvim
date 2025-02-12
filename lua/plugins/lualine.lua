return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "folke/tokyonight.nvim" }, -- Đảm bảo Lualine load sau khi theme có sẵn
  config = function()
    -- Cài đặt theme tokyonight
    require("tokyonight").setup({})
    vim.cmd("colorscheme tokyonight")

    -- Cấu hình Lualine
    require("lualine").setup {
      options = {
        theme = "tokyonight",
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      }
    }
  end
}
