return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            -- Kết nối giữa nvim-cmp và LuaSnip
            "saadparwaiz1/cmp_luasnip",
            -- Bộ sưu tập snippet phổ biến
            "rafamadriz/friendly-snippets",
        },
    },

    -- Các nguồn dữ liệu cho nvim-cmp (autocomplete)
    {
        "hrsh7th/cmp-nvim-lsp", -- Tự động hoàn thành từ LSP (Language Server Protocol)
        "hrsh7th/cmp-buffer", -- Hoàn thành từ nội dung buffer đang mở
        "hrsh7th/cmp-path", -- Hoàn thành đường dẫn file
        "hrsh7th/cmp-cmdline", -- Hoàn thành trong command line
    },

    -- Plugin chính: hệ thống tự động hoàn thành nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")                -- Gọi nvim-cmp
            require("luasnip.loaders.from_vscode").lazy_load() -- Tải snippets định dạng VSCode

            cmp.setup({
                -- Cách xử lý snippet khi chọn
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },

                -- Tùy chỉnh giao diện cửa sổ gợi ý & tài liệu
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                -- Thiết lập phím tắt trong chế độ insert khi hiển thị gợi ý
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Cuộn lên trong phần tài liệu
                    ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Cuộn xuống
                    ["<C-Space>"] = cmp.mapping.complete(), -- Gợi ý thủ công
                    ["<C-e>"] = cmp.mapping.abort(),    -- Hủy gợi ý
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter để chọn mục hiện tại
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- Di chuyển lên
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- Di chuyển xuống
                }),

                -- Thiết lập các nguồn dữ liệu cho gợi ý
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- Từ LSP
                    { name = "luasnip" }, -- Từ snippet
                    { name = "zls" }, -- (Zig Language Server, nếu dùng Zig)
                    { name = "buffer" }, -- Từ văn bản đang mở
                    { name = "path" }, -- Tên file, thư mục
                    { name = "ts_ls" }, -- (TypeScript LSP, nếu dùng)
                    { name = "render-markdown" },
                }),
            })
        end,
    },
}
