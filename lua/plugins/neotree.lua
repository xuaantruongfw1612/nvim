return {
	-- Plugin chính: neo-tree - thay thế file explorer mặc định trong Neovim
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x", -- Sử dụng nhánh v3.x (phiên bản mới nhất hiện tại)

	dependencies = {
		"nvim-lua/plenary.nvim", -- Thư viện tiện ích hỗ trợ Lua cho nhiều plugin
		"nvim-tree/nvim-web-devicons", -- Thêm icon đẹp vào file explorer (không bắt buộc nhưng nên có)
		"MunifTanjim/nui.nvim", -- UI components cho plugin sử dụng
		--"3rd/image.nvim", -- Hỗ trợ hiển thị hình ảnh trong cửa sổ preview
	},

	config = function()
		-- Thiết lập phím tắt cho neo-tree

		-- Nhấn <leader>v để mở file explorer bên trái và tự động focus file đang mở
		vim.keymap.set("n", "<leader>v", ":Neotree filesystem reveal left<CR>", {})

		-- Nhấn <leader>xx để đóng cửa sổ file explorer
		vim.keymap.set("n", "<leader>xx", ":Neotree filesystem close <CR>", {})
	end,
}
