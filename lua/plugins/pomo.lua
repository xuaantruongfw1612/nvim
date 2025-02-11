return {
    "epwalsh/pomo.nvim",
    version = "*",
    lazy = false, -- Đặt thành `false` để đảm bảo plugin luôn được tải
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },

    dependencies = {
        "rcarriga/nvim-notify",
        "nvim-lualine/lualine.nvim",
    },

    config = function()
        require("pomo").setup({
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
        })

        require("notify").setup({
            background_colour = "#282c34",
        })
    end,
}
