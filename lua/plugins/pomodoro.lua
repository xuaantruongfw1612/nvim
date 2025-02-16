local M = {}
local api = vim.api
local loop = vim.loop

-- Định nghĩa các session với nhiều mốc thời gian
local sessions = {
    s1 = {
        work_break_cycles = { {30 * 60, 7 * 60},
                              {30 * 60, 7 * 60},
                              {25 * 60, 5 * 60},
                              {25 * 60, 5 * 60}
        },
        current_cycle = 1
    },
    s2 = {         
        work_break_cycles = { {0.1 * 60, 0.1 * 60},
                              {0.2 * 60, 0.2 * 60},
                              {0.3 * 60, 0.3 * 60}
        },
        current_cycle = 1
    },
}

local timer_active = false
local in_break = false
local remaining_time = 0
local win, buf = nil, nil
local current_session = nil

local function create_floating_window(content)
    if win and api.nvim_win_is_valid(win) then
        api.nvim_win_close(win, true)
    end
    buf = api.nvim_create_buf(false, true)
    local width = #content + 0
    local opts = {
        relative = "editor",
        width = width,
        height = 1,
        row = vim.o.lines - 2,
        col = vim.o.columns - width - 34,
        style = "minimal",
        border = "none",
        focusable = false,
    }
    win = api.nvim_open_win(buf, false, opts)
    api.nvim_buf_set_lines(buf, 0, -1, false, { content })
end

local function update_display()
    local minutes = math.floor(remaining_time / 60)
    local seconds = remaining_time % 60
    local display_text = string.format("%s: %02d:%02d", in_break and "REST" or "WORK", minutes, seconds)
    create_floating_window(display_text)
end

local function update_timer()
    if not timer_active then return end
    if remaining_time <= 0 then
        if in_break then
            local session = sessions[current_session]
            session.current_cycle = session.current_cycle % #session.work_break_cycles + 1
            remaining_time = session.work_break_cycles[session.current_cycle][1]
            in_break = false
        else
            remaining_time = sessions[current_session].work_break_cycles[sessions[current_session].current_cycle][2]
            in_break = true
        end
        update_display()
    else
        remaining_time = remaining_time - 1
        update_display()
    end
    loop.new_timer():start(1000, 0, vim.schedule_wrap(update_timer))
end

local function start_pomodoro(session_name)
    if not sessions[session_name] then
        print("Session không tồn tại!")
        return
    end
    if not timer_active then
        current_session = session_name
        timer_active = true
        in_break = false
        sessions[session_name].current_cycle = 1
        remaining_time = sessions[session_name].work_break_cycles[1][1]
        update_display()
        update_timer()
    end
end

local function stop_pomodoro()
    timer_active = false
    if win and api.nvim_win_is_valid(win) then
        api.nvim_win_close(win, true)
        win, buf = nil, nil
    end
end

local function reset_pomodoro()
    if current_session then
        remaining_time = sessions[current_session].work_break_cycles[sessions[current_session].current_cycle][1]
        update_display()
    end
end

for session_name, _ in pairs(sessions) do
    api.nvim_create_user_command("Pomo" .. session_name, function()
        start_pomodoro(session_name)
    end, {})
end

api.nvim_create_user_command('Pomostop', stop_pomodoro, {})
api.nvim_create_user_command('Pomoreset', reset_pomodoro, {})

return M
