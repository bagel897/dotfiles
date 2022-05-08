local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
-- Telescope
local telescope = require("telescope")
telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<c-t>"] = trouble.open_with_trouble,
				["<C-d>"] = false,
				["<C-h>"] = "which_key",
			},
			n = { ["<c-t>"] = trouble.open_with_trouble },
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
telescope.load_extension("refactoring")
telescope.load_extension("file_browser")
telescope.load_extension("dap")
telescope.load_extension("lsp_handlers")
