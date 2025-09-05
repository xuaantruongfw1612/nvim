return {
	-- ⚙️ Mason: Cài đặt LSP/DAP/linter/... dễ dàng
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- 🔌 mason-lspconfig: Kết nối mason với lspconfig
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

	-- 🧠 LSP chính
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})

			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.eslint.setup({ capabilities = capabilities })
			lspconfig.pylsp.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
			vim.keymap.set("n", "gi", function()
				require("telescope.builtin").lsp_implementations()
			end, { desc = "Goto Implementation (Telescope)" })

			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename full project" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

			-- gr: tìm references trong project root
			vim.keymap.set("n", "gr", function()
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")
				local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
				if vim.fn.isdirectory(root) ~= 1 then
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					for _, c in ipairs(clients) do
						if c.config.root_dir then root = c.config.root_dir break end
					end
				end
				if root == "" then root = vim.fn.getcwd() end

				local clients = vim.lsp.get_clients({ bufnr = 0 })
				local client = clients[1]
				local params = vim.lsp.util.make_position_params(0, client and client.offset_encoding or "utf-8")
				params.context = { includeDeclaration = false }

				vim.lsp.buf_request(0, "textDocument/references", params, function(err, result)
					if err or not result or vim.tbl_isempty(result) then
						vim.notify("No references found", vim.log.levels.INFO)
						return
					end

					local filtered = {}
					for _, r in ipairs(result) do
						local path = vim.uri_to_fname(r.uri)
						if path:sub(1, #root) == root then table.insert(filtered, r) end
					end
					if vim.tbl_isempty(filtered) then
						vim.notify("No references found in project", vim.log.levels.INFO)
						return
					end

					local pickers = require("telescope.pickers")
					local finders = require("telescope.finders")
					local conf = require("telescope.config").values
					local entry_display = require("telescope.pickers.entry_display")
					local utils = require("telescope.utils")

					local displayer = entry_display.create({
						separator = " ",
						items = { { width = 50 }, { remaining = true } },
					})

					local function make_display(entry)
						local filename = utils.transform_path({}, entry.filename)
						local line_info = string.format("%s:%s", entry.lnum, entry.col)
						return displayer({ filename, line_info })
					end

					pickers.new({}, {
						prompt_title = "LSP References (Project)",
						finder = finders.new_table({
							results = filtered,
							entry_maker = function(entry)
								local filename = vim.uri_to_fname(entry.uri)
								local lnum = entry.range.start.line + 1
								local col = entry.range.start.character + 1
								return {
									value = entry,
									display = make_display,
									ordinal = filename .. ":" .. lnum .. ":" .. col,
									filename = filename,
									lnum = lnum,
									col = col,
								}
							end,
						}),
						sorter = conf.generic_sorter({}),
						previewer = conf.qflist_previewer({}),
						attach_mappings = function(prompt_bufnr, map)
							map("n", "<CR>", function()
								local entry = action_state.get_selected_entry()
								if entry then
									vim.lsp.util.jump_to_location(entry.value, "utf-8")
								end
								actions.close(prompt_bufnr)
							end)
							return true
						end,
					}):find()
				end)
			end, { desc = "References (project-wide)" })

			-- gR: chỉ trong thư mục hiện tại và con
			vim.keymap.set("n", "gR", function()
				local current_dir = vim.fn.expand("%:p:h")
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				local client = clients[1]
				local params = vim.lsp.util.make_position_params(0, client and client.offset_encoding or "utf-8")
				params.context = { includeDeclaration = false }

				vim.lsp.buf_request(0, "textDocument/references", params, function(err, result)
					if err or not result or vim.tbl_isempty(result) then
						vim.notify("No references found", vim.log.levels.INFO)
						return
					end

					local filtered = {}
					for _, r in ipairs(result) do
						local path = vim.uri_to_fname(r.uri)
						if path:sub(1, #current_dir) == current_dir then table.insert(filtered, r) end
					end
					if vim.tbl_isempty(filtered) then
						vim.notify("No references in current directory", vim.log.levels.INFO)
						return
					end

					local pickers = require("telescope.pickers")
					local finders = require("telescope.finders")
					local conf = require("telescope.config").values
					local entry_display = require("telescope.pickers.entry_display")
					local utils = require("telescope.utils")

					local displayer = entry_display.create({
						separator = " ",
						items = { { width = 50 }, { remaining = true } },
					})

					local function make_display(entry)
						local filename = utils.transform_path({}, entry.filename)
						local line_info = string.format("%s:%s", entry.lnum, entry.col)
						return displayer({ filename, line_info })
					end

					pickers.new({}, {
						prompt_title = "LSP References (Current Directory)",
						finder = finders.new_table({
							results = filtered,
							entry_maker = function(entry)
								local filename = vim.uri_to_fname(entry.uri)
								local lnum = entry.range.start.line + 1
								local col = entry.range.start.character + 1
								return {
									value = entry,
									display = make_display,
									ordinal = filename .. ":" .. lnum .. ":" .. col,
									filename = filename,
									lnum = lnum,
									col = col,
								}
							end,
						}),
						sorter = conf.generic_sorter({}),
						previewer = conf.qflist_previewer({}),
						attach_mappings = function(prompt_bufnr, map)
							map("n", "<CR>", function()
								local entry = require("telescope.actions.state").get_selected_entry()
								if entry then
									vim.lsp.util.jump_to_location(entry.value, "utf-8")
								end
								require("telescope.actions").close(prompt_bufnr)
							end)
							return true
						end,
					}):find()
				end)
			end, { desc = "References (current directory)" })

			vim.keymap.set("n", "<leader>fm", function()
				require("telescope.builtin").lsp_document_symbols()
			end, { desc = "Document symbols" })
		end,
	},
}
