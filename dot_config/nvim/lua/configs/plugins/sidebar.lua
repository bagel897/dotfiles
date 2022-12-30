local cfg = function()
	local sidebar = require("sidebar-nvim")
	local opts = {
		open = true,
		side = "right",
		sections = {
			"git",
			"diagnostics",
			"symbols",
			require("dap-sidebar-nvim.breakpoints"),
		},
		dap = {
			breakpoints = {
				icon = "🔍",
			},
		},
		disable_closing_prompt = true,
	}
	sidebar.setup(opts)
end
return { "sidebar-nvim/sidebar.nvim", "sidebar-nvim/sections-dap", enabled = false, config = cfg }
