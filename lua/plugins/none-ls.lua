return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },  -- Đảm bảo Plenary đã cài đặt
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      debug = false,  -- Bật debug nếu cần
      sources = {
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-width", "4" },
        }),
        null_ls.builtins.formatting.clang_format.with({
          extra_args = { "-style={IndentWidth: 4}" },
        }),
        null_ls.builtins.formatting.prettier.with({
          extra_args = { "--tab-width", "4", "--use-tabs", "false" },
        }),
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.mypy,
      },
    })

    -- Kiểm tra nếu LSP chưa bật thì không map phím
    if vim.lsp.buf ~= nil then
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end
  end,
}
