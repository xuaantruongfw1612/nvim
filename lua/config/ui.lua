local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Logo (banner) với chữ Trường
dashboard.section.header.val = {
  [[████████╗██████╗ ██╗   ██╗ ██████╗ ███╗   ██╗ ██████╗ ]],
  [[╚══██╔══╝██╔══██╗██║   ██║██╔═══██╗████╗  ██║██╔════╝ ]],
  [[   ██║   ██████╔╝██║   ██║██║   ██║██╔██╗ ██║██║  ███╗]],
  [[   ██║   ██╔══██╗██║   ██║██║   ██║██║╚██╗██║██║   ██║]],
  [[   ██║   ██║  ██║╚██████╔╝╚██████╔╝██║ ╚████║╚██████╔╝]],
  [[   ╚═╝   ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ]],
  [[                                                    ]],
  [[                  Welcome to Nvim                   ]],
}

-- Các nút chức năng
dashboard.section.buttons.val = {
  dashboard.button("u", "  Modules Update", ":Lazy update<CR>"),
  dashboard.button("t", "  TS Update", ":TSUpdate<CR>"),
  dashboard.button("s", "  Startuptime", ":StartupTime<CR>"),
  dashboard.button("n", "  New File", ":ene <BAR> startinsert<CR>"),
  dashboard.button("p", "  Project", ":Telescope projects<CR>"),
  dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- Footer (tuỳ chọn)
dashboard.section.footer.val = function()
  return "⚡ Neovim loaded " ..
      vim.fn.len(vim.fn.globpath(vim.o.runtimepath, "plugin/**/*.vim", 0, 1)) .. " plugins"
end

dashboard.section.footer.opts.hl = "Comment"

-- Layout
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
