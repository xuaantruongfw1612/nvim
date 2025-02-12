return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Biểu tượng đẹp hơn
    config = function()
        require("lualine").setup{
            options = {
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                theme = "tokyonight"
            }
        }
    end
}

