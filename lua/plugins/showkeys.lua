local api = vim.api
local buf, win
local key_history = {}
local timer = vim.loop.new_timer()

-- Chuyển đổi phím đặc biệt sang ký hiệu tùy chỉnh

local function map_special_key(key)
    local key_map = {
        ["\t"] = "⇥",    -- Tab
        ["\n"] = "⏎",    -- Enter
        [" "] = "␣",     -- Space
        ["\27"] = "⎋"    -- Esc
    }
    return key_map[key] or key
end

-- Tạo cửa sổ 
local function create_floating_win()
    if win and api.nvim_win_is_valid(win) then
        return -- Nếu cửa sổ đã tồn tại thì không tạo mới
    end
    buf = api.nvim_create_buf(false, true) -- Tạo buffer ẩn
end

-- Ẩn cửa sổ sau 2s nếu không có phím bấm
local function hide_window()
    if win and api.nvim_win_is_valid(win) then
        api.nvim_win_close(win, true)
        win = nil
        key_history = {} -- Xóa lịch sử phím khi ẩn
    end
end

-- Cập nhật cửa sổ khi có phím bấm mới
local function update_key_display(key)
    create_floating_win() -- Hiện cửa sổ nếu chưa có

    table.insert(key_history, map_special_key(key)) -- Ghi lại phím bấm
    if #key_history > 20 then -- Giới hạn số phím hiển thị
        table.remove(key_history, 1)
    end
    local key_str = "" .. table.concat(key_history, "")

    -- Tính toán chiều rộng dựa trên độ dài của chuỗi phím bấm
    local win_width = #key_str + 0
    local max_width = vim.o.columns - 10 -- Giới hạn tối đa
    if win_width > max_width then
        win_width = max_width
    end

    -- Hiển thị ở dòng cuối cùng của màn hình
    local opts = {
        relative = "editor",
        width = win_width,
        height = 1, -- Chỉ có 1 dòng
        row = vim.o.lines - 2, -- Hiển thị ở dòng cuối cùng
        col = 0, -- Cách mép trái
        style = "minimal",
        border = "none"
    }

    -- Nếu cửa sổ chưa tồn tại, tạo mới
    if not win or not api.nvim_win_is_valid(win) then
        win = api.nvim_open_win(buf, false, opts)
    else
        -- Nếu cửa sổ đã tồn tại, cập nhật kích thước và vị trí
        api.nvim_win_set_config(win, opts)
    end

    api.nvim_buf_set_lines(buf, 0, -1, false, { key_str })

    -- Reset bộ đếm thời gian
    timer:stop()
    timer:start(1000, 0, vim.schedule_wrap(hide_window))
end

-- ShowKeys
vim.on_key(function(key)
    update_key_display(key)
end, api.nvim_create_namespace("key_logger"))

return {
    "folke/which-key.nvim",
    config =function()
    require("which-key").setup({})
    end
}
