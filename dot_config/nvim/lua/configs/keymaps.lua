local wk = require("which-key")

local dap = require("dap")
local builtin = require("telescope.builtin")
local telescope = require("telescope")
local neogit = require("neogit")

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
wk.register({
	w = {
		name = "workspace/worktree",
		a = { vim.lsp.buf.add_workspace_folder, "add workspace folder" },
		r = { vim.lsp.buf.remove_workspace_folder, "remove workspace folder" },
		l = {
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"list workspace folders",
		},
		c = {
			function()
				require("telescope").extensions.git_worktree.create_git_worktree()
			end,
			"create git worktree",
		},
		s = {
			function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end,
			"switch git worktrees",
		},
	},
	d = {
		name = "debug",
		n = { dap.step_over, "step over" },
		s = { dap.step_into, "step into" },
		o = { dap.step_out, "step out" },
		u = { dap.run_to_cursor, "run to cursor" },
		b = { dap.toggle_breakpoint, "breakpoint" },
		c = { dap.continue, "continue" },
		r = { dap.run_last, "run_last" },
		q = {
			function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			"conditional",
		},
		x = { dap.terminate, "terminate" },
		p = { dap.pause, "pause" },
		f = {
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			"test method",
		},
		t = {
			function()
				require("neotest").run.run()
			end,
			"test nearest",
		},
		ds = { require("dap-python").debug_selection, "debug selection python" },
	},
	l = {
		name = "lsp",
		d = { "<CMD> :Docstring <CR>", "Docstring" },
		t = { vim.lsp.buf.type_definition, "type definition" },
		r = { "<cmd>Lspsaga rename<CR>", "rename" },
		a = {
			"<cmd>Lspsaga code_action<CR>",
			"code actions",
		},
		f = { vim.lsp.buf.formatting, "format" },
		q = { "<cmd>Lspsaga hover_doc<CR>", "documentation" },
		i = { vim.lsp.buf.implementation, "implementation" },
		c = { "<cmd>Lspsaga lsp_finder<CR>", "incoming calls" },
		o = { vim.lsp.buf.outgoing_calls, "outgoing calls" },
	},
	f = {
		name = "find",
		f = { builtin.find_files, "files" },
		l = { builtin.lsp_document_symbols, "lsp" },
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
				local sopts = { fuzzy = false, case_mode = "ignore_case" }
				builtin.current_buffer_fuzzy_find(sopts)
			end,
			"current buffer",
		},
		c = { builtin.commands, "commands" },
		-- ? = {[[<cmd>lua require('builtin').oldfiles()<CR>]],"old files"},
	},
	["<space>"] = { builtin.buffers, "buffers" },
	g = { neogit.open, "Git" },
	h = {
		name = "Git",
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		C = {
			"<cmd>Telescope git_bcommits<cr>",
			"Checkout commit(for current file)",
		},
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Git Diff",
		},
	},
	t = { "<CMD>:ToggleTerm<CR>", "Toggle Terminal" },
	s = { "<cmd>LSoutlineToggle<CR>", "symbols outline" },
	r = {
		r = {
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			"Run file",
		},
		s = {
			function()
				require("neotest").summary.toggle()
			end,
			"Summary",
		},
		name = "test",
	},
	u = {
		function()
			require("packer").sync()
		end,
		"Update",
	},
	c = {
		name = "competitive",
		r = {
			function()
				require("cphelper.receive").receive()
			end,
			"receive",
		},
		t = {
			function()
				require("cphelper.process_tests").process()
			end,
			"run tests",
		},
	},
}, { prefix = "<leader>" })
wk.register({
	l = {
		name = "lsp",
		a = { "<cmd>Lspsaga code_action<CR>", "range code actions" },
	},
}, { prefix = "<leader>", mode = "v" })
vim.api.nvim_set_keymap(
	"v",
	"<leader>lb",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{}
)
