return {
    "xuaantruongfw1612/vietnamese-nvim",
    event = "InsertEnter",
    config = function()
        require("vietnamese").setup()
    end,
    vim.api.nvim_set_keymap("n", "la", "<Esc>:VietnameseToggle<CR>", { noremap = true, silent = true })
}

