local M = {}
local api = vim.api
local loop = vim.loop

local sessions = {
	s1 = {
		work_break_cycles = {
			{ 30 * 60, 7 * 60 },
			{ 30 * 60, 7 * 60 },
			{ 25 * 60, 5 * 60 },
			{ 25 * 60, 5 * 60 },
		},
		current_cycle = 1,
	},
	s2 = {
		work_break_cycles = {
			{ 0.1 * 60, 0.1 * 60 },
			{ 0.2 * 60, 0.2 * 60 },
			{ 0.3 * 60, 0.3 * 60 },
		},
		current_cycle = 1,
	},
}

local timer_active = false
local in_break = false
local remaining_time = 0
local win, buf = nil, nil
local current_session = nil
local show_overtime = false

local function create_floating_window(content, width, height, is_overtime)
	if win and api.nvim_win_is_valid(win) then
		api.nvim_win_close(win, true)
	end
	buf = api.nvim_create_buf(false, true)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = vim.o.lines - height - 1,
		col = is_overtime and 0 or (vim.o.columns - width - 34), -- Left for overtime, right for timer
		style = "minimal",
		border = "none",
		focusable = false,
	}
	win = api.nvim_open_win(buf, false, opts)

	-- Calculate padding for centering
	local content_length = #content
	local horizontal_padding = math.floor((width - content_length) / 2)
	local vertical_padding = math.floor((height - 1) / 2)

	-- Create lines with centered content
	local lines = {}
	for _ = 1, vertical_padding do
		table.insert(lines, "")
	end

	local padded_content = string.rep(" ", horizontal_padding) .. content
	if (width - content_length) % 2 ~= 0 then
		padded_content = padded_content .. " " -- Extra space for odd width
	end
	table.insert(lines, padded_content)

	for _ = 1, height - vertical_padding - 1 do
		table.insert(lines, "")
	end

	api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

local function update_display()
	if show_overtime then
		create_floating_window("X I N  D Ừ N G  C O D E", 93, 50, true) -- Window on left, text centered
	elseif remaining_time > 0 then
		local minutes = math.floor(remaining_time / 60)
		local seconds = remaining_time % 60
		local display_text = string.format("%s: %02d:%02d", in_break and "REST" or "WORK", minutes, seconds)
		create_floating_window(display_text, #display_text, 1, false) -- Window on right, text left-aligned
	end
end

local function update_timer()
	if not timer_active then
		return
	end

	if remaining_time <= 0 then
		if not show_overtime then
			show_overtime = true
			update_display()
			-- Use the break time of the current cycle as overtime duration
			local overtime_duration = sessions[current_session].work_break_cycles[sessions[current_session].current_cycle][2]
				* 1000 -- Convert to milliseconds
			loop.new_timer():start(
				overtime_duration,
				0,
				vim.schedule_wrap(function()
					show_overtime = false
					if in_break then
						local session = sessions[current_session]
						session.current_cycle = session.current_cycle % #session.work_break_cycles + 1
						remaining_time = session.work_break_cycles[session.current_cycle][1]
						in_break = false
					else
						remaining_time =
							sessions[current_session].work_break_cycles[sessions[current_session].current_cycle][2]
						in_break = true
					end
					update_display()
					update_timer()
				end)
			)
		end
	else
		remaining_time = remaining_time - 1
		update_display()
	end
	if not show_overtime then
		loop.new_timer():start(1000, 0, vim.schedule_wrap(update_timer))
	end
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
		show_overtime = false
		sessions[session_name].current_cycle = 1
		remaining_time = sessions[session_name].work_break_cycles[1][1]
		update_display()
		update_timer()
	end
end

local function stop_pomodoro()
	timer_active = false
	show_overtime = false
	if win and api.nvim_win_is_valid(win) then
		api.nvim_win_close(win, true)
		win, buf = nil, nil
	end
end

local function reset_pomodoro()
	if current_session then
		show_overtime = false
		remaining_time = sessions[current_session].work_break_cycles[sessions[current_session].current_cycle][1]
		update_display()
	end
end

for session_name, _ in pairs(sessions) do
	api.nvim_create_user_command("Pomo" .. session_name, function()
		start_pomodoro(session_name)
	end, {})
end

api.nvim_create_user_command("Pomostop", stop_pomodoro, {})
api.nvim_create_user_command("Pomoreset", reset_pomodoro, {})

vim.keymap.set('n', '<leader>p1', ':Pomos1<CR>', { noremap = true, silent = true, desc = "Start Pomodoro Session 1" })
vim.api.nvim_set_keymap('n', '<leader>p2', ':Pomos2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ps', ':Pomostop<CR>', { noremap = true, silent = true, desc = "Stop Pomodoro" })
vim.keymap.set('n', '<leader>pr', ':Pomoreset<CR>', { noremap = true, silent = true, desc = "Reset Pomodoro" })

return M
