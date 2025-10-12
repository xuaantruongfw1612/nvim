return {
    -- Mason: Cài đặt LSP/DAP/linter/... dễ dàng
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    -- Mason-lspconfig: Kết nối mason với lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
            ensure_installed = {
                "lua_ls",
                "clangd",
                "jdtls",
                --"pyright",
                --"html",
                --"cssls",
                --"ts_ls",
                --"bashls",
                "pylsp",
                --"eslint",
            },
        },
    },
    -- LSP chính
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Keymaps
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
            vim.keymap.set("n", "gi", function()
                require("telescope.builtin").lsp_implementations()
            end, { desc = "Goto Implementation (Telescope)" })
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename full project" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
            
            vim.keymap.set("n", "<leader>fm", function()
                require("telescope.builtin").lsp_document_symbols()
            end, { desc = "Document symbols" })
        end,
    },
}

