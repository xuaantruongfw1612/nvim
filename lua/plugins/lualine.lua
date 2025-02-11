return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Biểu tượng đẹp hơn
    config = function()
        require("lualine").setup({
            options = {
                theme = "tokyonight", -- Thay đổi theme, có thể thử 'gruvbox', 'dracula', v.v.
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" }, -- NORMAL, INSERT, VISUAL, v.v.
                lualine_b = { "branch" }, -- Hiển thị tên branch Git
                lualine_c = { "filename" }, -- Hiển thị file hiện tại
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" } -- Dòng : Cột
            },
        })
    end
}
