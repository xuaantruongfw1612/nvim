return {
    "epwalsh/pomo.nvim",
    version = "*",
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },

    dependencies = {
        -- Optional, but highly recommended if you want to use the "Default" timer
        "rcarriga/nvim-notify",
        config = function()
            local play_sound = function()
                local home_dir = os.getenv("HOME")
                local sound_path = home_dir .. "/.config/nvim/break.wav"  -- Đổi sang .wav nếu sử dụng paplay

                -- Chạy paplay (PulseAudio) để phát âm thanh
                vim.loop.spawn("paplay", {
                    args = { sound_path },
                    detached = true,
                }, function()
                    print("Sound finished playing")
                end)
                
                -- Sau khi thời gian kết thúc, tắt âm thanh
                vim.defer_fn(function()
                    vim.fn.system("pkill paplay")  -- Tắt tất cả tiến trình paplay
                    print("Sound stopped after time is up")
                end, 15000)  -- Tạm dừng 15 giây (thời gian để chắc chắn âm thanh đã kết thúc)
            end

            require("notify").setup({
                background_colour = "#1e1e2e",
                on_open = function(notification)
                    if notification then
                        play_sound()
                    end
                end,
            })
            
            require("lualine").setup {
                sections = {
                    lualine_x = {
                        function()
                            local ok, pomo = pcall(require, "pomo")
                            if not ok then
                                return ""
                            end

                            local timer = pomo.get_first_to_finish()
                            if timer == nil then
                                return ""
                            end

                            return "󰄉 " .. tostring(timer)
                        end,
                        "encoding",
                        "fileformat",
                        "filetype",
                    },
                },
            }
        end,
    },
    opts = {
        work_time = 25,
        break_time = 5,
        long_break_time = 15,
        notifier = {
            sticky = true,
        },
        sessions = {
            pomodoro = {
                { name = "Work",        duration = "30m" },
                { name = "Short Break", duration = "5m" },
                { name = "Work",        duration = "25m" },
                { name = "Short Break", duration = "7m" },
                { name = "Work",        duration = "25m" },
                { name = "Long Break",  duration = "10m" },
            },
        },
    },
}
