return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "moon",
        transparent = true,  -- Giữ trong suốt
        terminal_colors = true,
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/tokyonight.nvim" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          icons_enabled = true,
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
        }
      })
    end
  },

  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 999,  -- Load ngay sau theme
    config = function()
      require("transparent").setup({
        enable = true,
        extra_groups = { "Normal", "NormalNC", "EndOfBuffer", "Lualine" }, -- Giữ cả lualine trong suốt
      })
    end
  }
}

