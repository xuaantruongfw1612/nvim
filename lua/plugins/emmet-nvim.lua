-- web
return {
	"mattn/emmet-vim",
	config = function()
		vim.g.user_emmet_install_global = 0
		vim.cmd([[
      autocmd FileType html,css,vue EmmetInstall
    ]])
	end,
}
