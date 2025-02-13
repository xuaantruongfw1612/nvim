local api = vim.api
local loop = vim.loop

-- Cấu hình thời gian (giây)
local work_time = 0.1 * 60
local break_time = 0.1 * 60
local timer_active = false
local in_break = false
local remaining_time = work_time
local win, buf = nil, nil

-- Hàm tạo floating window
local function create_floating_window(content)
    if win and api.nvim_win_is_valid(win) then
        api.nvim_win_close(win, true)
    end
    buf = api.nvim_create_buf(false, true)
    local width = #content + 0
    local height = 1
    local opts = {
        relative = "editor",
        width = width,
        height = height,
        row = vim.o.lines - 3,
        col = vim.o.columns - width - 0,
        style = "minimal",
        border = "none",
        focusable = false,
    }
    win = api.nvim_open_win(buf, false, opts)
    api.nvim_buf_set_lines(buf, 0, -1, false, { content })
end

-- Hàm cập nhật hiển thị
local function update_display()
    local minutes = math.floor(remaining_time / 60)
    local seconds = remaining_time % 60
    local display_text = string.format("%s: %02d:%02d", in_break and "BREAK" or "WORK", minutes, seconds)
    create_floating_window(display_text)
end

-- Hàm cập nhật thời gian
local function update_timer()
    if not timer_active then return end
    if remaining_time <= 0 then
        if in_break then
            remaining_time = work_time
            in_break = false
        else
            remaining_time = break_time
            in_break = true
        end
        update_display() -- Cập nhật lại cửa sổ khi chuyển trạng thái
    else
        remaining_time = remaining_time - 1
        update_display()
    end
    loop.new_timer():start(1000, 0, vim.schedule_wrap(update_timer))
end

-- Hàm bắt đầu Pomodoro
local function start_pomodoro()
    if not timer_active then
        timer_active = true
        in_break = false
        remaining_time = work_time
        update_display()
        update_timer()
    end
end

-- Hàm dừng Pomodoro
local function stop_pomodoro()
    timer_active = false
    if win and api.nvim_win_is_valid(win) then
        api.nvim_win_close(win, true)
        win, buf = nil, nil
    end
end

-- Hàm reset Pomodoro
local function reset_pomodoro()
    remaining_time = in_break and break_time or work_time
    update_display()
end

-- Tạo lệnh trong Neovim
api.nvim_create_user_command('PomoStart', start_pomodoro, {})
api.nvim_create_user_command('PomoStop', stop_pomodoro, {})
api.nvim_create_user_command('PomoReset', reset_pomodoro, {})

