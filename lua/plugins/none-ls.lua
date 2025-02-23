return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua, -- lua
        null_ls.builtins.formatting.clang_format, -- c/cpp
        null_ls.builtins.formatting.prettier, -- JS, HTML, CSS,...
        null_ls.builtins.formatting.isort, -- python
        null_ls.builtins.diagnostics.mypy, -- python
        --null_ls.builtins.formatting.black, -- python
        --null_ls.builtins.diagnostics.ruff, -- python modern
        --null_ls.builtins.formatting.gofumpt,
        --null_ls.builtins.code_actions.impl,
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
