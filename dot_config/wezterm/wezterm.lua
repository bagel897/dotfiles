local wezterm = require("wezterm")

return {
	font = wezterm.font("FiraCode Nerd Font Mono"),
	color_scheme = "Catppuccin Mocha",
	ssh_domains = {
		{
			name = "bagelpi",
			remote_address = "100.96.192.103",
			username = "bageljr",
		},
		{
			name = "rocket",
			remote_address = "10.157.95.28",
			username = "aa87445",
			assume_shell = "Posix",
			remote_wezterm_path = "/home/aa87445/.local/bin/wezterm",
		},
		{
			name = "cs",
			remote_address = "trix.cs.utexas.edu",
			username = "bageljr",
			assume_shell = "Posix",
			remote_wezterm_path = "/u/bageljr/.local/bin/wezterm",
		},
	},
	hide_mouse_cursor_when_typing = false,
	hyperlink_rules = {
		-- Linkify things that look like URLs and the host has a TLD name.
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},

		-- linkify email addresses
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
			format = "mailto:$0",
		},

		-- file:// URI
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = [[\bfile://\S*\b]],
			format = "$0",
		},

		-- Linkify things that look like URLs with numeric addresses as hosts.
		-- E.g. http://127.0.0.1:8000 for a local development server,
		-- or http://192.168.1.1 for the web interface of many routers.
		{
			regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
			format = "$0",
		},

		-- -- Make username/project paths clickable. This implies paths like the following are for GitHub.
		-- -- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
		-- -- As long as a full URL hyperlink regex exists above this it should not match a full URL to
		-- -- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
		-- {
		-- 	regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
		-- 	format = "https://www.github.com/$1/$3",
		-- },
	},
	-- window_background_opacity = 0.9,
}
