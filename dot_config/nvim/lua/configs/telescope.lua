-- local actions = require("telescope.actions")
-- local trouble = require("trouble.providers.telescope")
-- Telescope
local telescope = require("telescope")
telescope.setup({
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
telescope.load_extension("fzf")
telescope.load_extension("refactoring")
telescope.load_extension("file_browser")
telescope.load_extension("dap")
telescope.load_extension("lsp_handlers")
--Add leader shortcuts

local wk = require("which-key")
local builtin = require("telescope.builtin")
wk.register({
	f = {
		name = "find",
		g = { ":Telescope file_browser <CR>", "file browser" },
		f = { builtin.find_files, "files" },
		b = { builtin.current_buffer_fuzzy_find, "buffer" },
		h = { builtin.help_tags, "help" },
		t = { builtin.tags, "tags" },
		d = { builtin.grep_string, "grep string" },
		p = { builtin.live_grep, "live grep" },
		o = {
			function()
				builtin.tags({ only_current_buffer = true })
			end,
			"current buffer",
		},
		s = {
			function()
				builtin.current_buffer_fuzzy_find({ fuzzy = false, case_mode = "ignore_case" })
			end,
			"current buffer",
		},
		c = { builtin.commands, "commands" },
		-- ? = {[[<cmd>lua require('builtin').oldfiles()<CR>]],"old files"},
	},
	["<space>"] = { builtin.buffers, "buffers" },
}, { prefix = "<leader>" })
-- local neogit = require("neogit")
-- wk.register({
-- 	g = {
-- 		name = "git",
-- 		b = { builtin.git_branches, "branches" },
-- 		s = { builtin.git_status, "status" },
-- 		h = { builtin.git_commits, "commit history" },
-- 		w = {
-- 			function()
-- 				neogit.open({ "stage" })
-- 			end,
-- 			"stage",
-- 		},
-- 		c = {
-- 			function()
-- 				neogit.open({ "commit" })
-- 			end,
-- 			"commit",
-- 		},
-- 		p = {
-- 			function()
-- 				neogit.open({ "push" })
-- 			end,
-- 			"push",
-- 		},
-- 		g = {
-- 			function()
-- 				neogit.open({ "pull" })
-- 			end,
-- 			"pull",
-- 		},
-- 		d = {
-- 			function()
-- 				neogit.open({ "diff" })
-- 			end,
-- 			"diff",
-- 		},
--
-- 		-- s = { [[<cmd>lua require('builtin').git_stash()<CR>]], "stash" },
-- 	},
-- }, { prefix = "<leader>" })
-- local refactoring = require("refactoring")
wk.register({
	r = { telescope.extensions.refactoring.refactors, "refactors" },
}, { prefix = "<leader>", mode = "v" })

telescope.load_extension("dap")
-- vim.api.nvim_set_keymap(
-- 	"v",
-- 	"<Leader>te",
-- 	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
-- 	{ noremap = true, silent = true, expr = false }
-- )
-- vim.api.nvim_set_keymap(
-- 	"v",
-- 	"<Leader>tf",
-- 	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
-- 	{ noremap = true, silent = true, expr = false }
-- )
-- vim.api.nvim_set_keymap(
-- 	"v",
-- 	"<Leader>tv",
-- 	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
-- 	{ noremap = true, silent = true, expr = false }
-- )
-- vim.api.nvim_set_keymap(
-- 	"v",
-- 	"<Leader>ti",
-- 	[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
-- 	{ noremap = true, silent = true, expr = false }
-- )
