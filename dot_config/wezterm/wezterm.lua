local wezterm = require("wezterm")

return {
	font = wezterm.font("FiraCode Nerd Font Mono"),

	color_scheme = "Catppuccin Mocha",
	ssh_domains = {
		{
			name = "rocket",
			remote_address = "10.157.95.31",
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

	-- window_background_opacity = 0.9,
}
