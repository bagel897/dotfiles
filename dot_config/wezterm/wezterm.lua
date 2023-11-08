local wezterm = require("wezterm")
local config = {}
config.color_scheme = "Catppuccin Mocha"
config.scrollback_lines = 10000
config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- make task numbers clickable
-- the first matched regex group is captured in $1.
table.insert(config.hyperlink_rules, {
	regex = [[\b[tt](\d+)\b]],
	format = "https://example.com/tasks/?t=$1",
})
config.hide_mouse_cursor_when_typing = false
-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
-- table.insert(config.hyperlink_rules, {
-- 	regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
-- 	format = "https://www.github.com/$1/$3",
-- })
config.ssh_domains = wezterm.default_ssh_domains()
-- config.ssh_domains = {
--
-- 	{
-- 		name = "rocket",
-- 		remote_address = "10.157.95.28",
-- 		username = "aa87445",
-- 		assume_shell = "Posix",
-- 		remote_wezterm_path = "/home/aa87445/.local/bin/wezterm",
-- 	},
-- }
return config
