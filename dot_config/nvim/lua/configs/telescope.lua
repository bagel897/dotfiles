local actions = require("telescope.actions")
-- Telescope
local telescope = require("telescope")
telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-d>"] = false,
				["<C-h>"] = "which_key",
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			overwrite_generic_sorter = true,
			overwrite_file_sorter = true,
			case_mode = "smart_case",
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
		},
	},
})
-- Enable telescope fzf native
telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("dap")
telescope.load_extension("lsp_handlers")
