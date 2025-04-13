-- Khi bạn đặt con trỏ vào lỗi / cảnh báo,
-- VSCode thường có cái bóng đèn 💡 hiện ra → nhấn vào để quick fix / import, v.v.
-- Plugin này mô phỏng y chang trong nvim

return {
  "kosayoda/nvim-lightbulb",
  config = function()
    -- Tắt hiển thị tự động
    require("nvim-lightbulb").setup({
      autocmd = { enabled = false },
    })

    -- Gán phím để gọi bóng đèn thủ công (nếu có code action)
    vim.keymap.set("n", "<leader>lb", function()
      require("nvim-lightbulb").update_lightbulb()
    end, { desc = "Hiện lightbulb thủ công" })
  end,
}
