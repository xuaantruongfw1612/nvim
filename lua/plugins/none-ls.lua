return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
      null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-width", "4" }, -- Lua: 4 spaces
        }),
        null_ls.builtins.formatting.clang_format.with({
          extra_args = { "-style={IndentWidth: 4}" }, -- C/C++
        }),
        null_ls.builtins.formatting.prettier.with({
          extra_args = { "--tab-width", "4", "--use-tabs", "false" }, -- JS, HTML, CSS
        }),
        null_ls.builtins.formatting.isort, -- Python (mặc định theo PEP8)
        null_ls.builtins.diagnostics.mypy, -- Python type checking
        --null_ls.builtins.formatting.black, -- python
        --null_ls.builtins.diagnostics.ruff, -- python modern
        --null_ls.builtins.formatting.gofumpt,
        --null_ls.builtins.code_actions.impl,
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
