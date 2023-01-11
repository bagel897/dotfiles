-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.g.neo_tree_remove_legacy_commands = 1
-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

local opts = {
	close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	filesystem = {
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		-- time the current file is changed while the tree is open.
		use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
		-- instead of relying on nvim autocmd events.
	},
	sources = {
		"filesystem",
		"buffers",
		"git_status",
		"diagnostics",
		-- ...and any additional source
	},
	source_selector = {
		winbar = true,
		statusline = false,
	},
	-- These are the defaults
	diagnostics = {
		bind_to_cwd = true,
		diag_sort_function = "severity", -- "severity" means diagnostic items are sorted by severity in addition to their positions.
		-- "position" means diagnostic items are sorted strictly by their positions.
		-- May also be a function.
		follow_behavior = { -- Behavior when `follow_current_file` is true
			always_focus_file = false, -- Focus the followed file, even when focus is currently on a diagnostic item belonging to that file.
			expand_followed = true, -- Ensure the node of the followed file is expanded
			collapse_others = true, -- Ensure other nodes are collapsed
		},
		follow_current_file = true,
		group_dirs_and_files = true, -- when true, empty folders and files will be grouped together
		group_empty_dirs = true, -- when true, empty directories will be grouped together
		show_unloaded = true, -- show diagnostics from unloaded buffers
	},
}
return {

	"nvim-neo-tree/neo-tree.nvim",
	keys = {
		{ "<C-n>", "<cmd> :Neotree toggle<cr>", desc = "Open Neo-tree" },
	},
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup(opts)
	end,
}
