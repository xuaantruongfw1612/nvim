return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "folke/tokyonight.nvim" },
  config = function()
    -- Cấu hình tokyonight trước khi load Lualine
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
