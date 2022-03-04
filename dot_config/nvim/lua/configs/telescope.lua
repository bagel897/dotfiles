-- local actions = require("telescope.actions")
-- local trouble = require("trouble.providers.telescope")
-- Telescope
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				-- ["<c-t>"] = trouble.open_with_trouble,
				["<C-d>"] = false,
				["<C-h>"] = "which_key",
			},
			-- n = { ["<c-t>"] = trouble.open_with_trouble },
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
require("telescope").load_extension("fzf")
require("telescope").load_extension("refactoring")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("dap")
require("telescope").load_extension("lsp_handlers")
--Add leader shortcuts
vim.api.nvim_set_keymap(
	"n",
	"<leader><space>",
	[[<cmd>lua require('telescope.builtin').buffers()<CR>]],
	{ noremap = true, silent = true }
)
local wk = require("which-key")
wk.register({
	f = {
		name = "find",
		g = { ":Telescope file_browser <CR>", "file browser" },
		f = { [[<cmd>lua require('telescope.builtin').find_files()<CR>]], "files" },
		b = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", "buffer" },
		h = { [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], "help" },
		t = { [[<cmd>lua require('telescope.builtin').tags()<CR>]], "tags" },
		d = { [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], "grep string" },
		p = { [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], "live grep" },
		o = { [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], "current buffer" },
		c = { "<cmd>lua require('telescope.builtin').commands()<CR>", "commands" },
		-- ? = {[[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],"old files"},
	},
}, { prefix = "<leader>" })
vim.api.nvim_set_keymap(
	"n",
	"<leader>tr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)
require("telescope").load_extension("dap")
vim.api.nvim_set_keymap(
	"v",
	"<Leader>te",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"v",
	"<Leader>tf",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"v",
	"<Leader>tv",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap(
	"v",
	"<Leader>ti",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
