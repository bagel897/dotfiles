return {
	"glepnir/dashboard-nvim",
	dependencies = { "folke/lazy.nvim" },
	config = function()
		local home = os.getenv("HOME")
		local db = require("dashboard")
		db.preview_file_path = home .. "/.config/nvim/static/neovim.cat"
		db.preview_file_height = 12
		db.preview_file_width = 80
		db.hide_statusline = false
		db.custom_center = {
			{
				icon = "  ",
				desc = "Recently laset session                  ",
				shortcut = "SPC s l",
				action = "SessionLoad",
			},
			{
				icon = "  ",
				desc = "Find  File                              ",
				action = "Telescope find_files find_command=rg,--hidden,--files",
				shortcut = "SPC f f",
			},
			{
				icon = "  ",
				desc = "Open Personal dotfiles                  ",
				action = "Telescope dotfiles path=" .. home .. "/.config",
				shortcut = "SPC f d",
			},
		}
	end,
}
