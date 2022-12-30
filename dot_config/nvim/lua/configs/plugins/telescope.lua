return {
	"nvim-telescope/telescope.nvim",
	"gbrlsnchs/telescope-lsp-handlers.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	config = function()
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
	end,
	dependencies = { { "nvim-lua/plenary.nvim" } },
}
