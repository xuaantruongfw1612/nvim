return {
    "epwalsh/pomo.nvim",
    version = "*",
    lazy = false,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },

    dependencies = {
        -- Optional, but highly recommended if you want to use the "Default" timer
        "rcarriga/nvim-notify",
        {
            "nvim-lualine/lualine.nvim",
            config = function()
                require("lualine").setup()
            end
        }
    },
    
    config = function()
        local play_sound = function()
            local home_dir = os.getenv("HOME")
            local sound_path = home_dir .. "/.config/nvim/break.mp3"
            vim.loop.spawn("paplay", {
                args = { sound_path },
                detached = true,
            }, function()
                print("Sound finished playing")
            end)

            vim.defer_fn(function()
                -- Không cần pkill khi dùng paplay vì nó tự động dừng
                print("Sound played")
            end, 15000)
        end

        require("notify").setup({
            background_colour = "#282c34",
        })
    end,

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
                { name = "Short Break", duration = "7m" },
                { name = "Work",        duration = "25m" },
                { name = "Short Break", duration = "7m" },
                { name = "Work",        duration = "25m" },
                { name = "Long Break",  duration = "10m" },
            },
        },
    },
}
