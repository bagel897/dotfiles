local wk = require("which-key")

local dap = require("dap")
local builtin = require("telescope.builtin")
local telescope = require("telescope")
wk.register({
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
		e = { require("dapui").close, "close" },
		p = { dap.pause, "pause" },
	},
	l = {
		name = "lsp",
		d = { vim.lsp.buf.type_definition, "type definition" },
		r = { vim.lsp.buf.rename, "rename" },
		a = { "<cmd>CodeActionMenu<CR>", "code actions" },
		f = { vim.lsp.buf.formatting, "format" },
		q = { vim.lsp.buf.hover, "documentation" },
		i = { vim.lsp.buf.implementation, "implementation" },
		c = { vim.lsp.buf.incoming_calls, "incoming calls" },
		o = { vim.lsp.buf.outgoing_calls, "outgoing calls" },
	},
	f = {
		name = "find",
		g = { ":Telescope file_browser <CR>", "file browser" },
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
				builtin.current_buffer_fuzzy_find({ fuzzy = false, case_mode = "ignore_case" })
			end,
			"current buffer",
		},
		c = { builtin.commands, "commands" },
		-- ? = {[[<cmd>lua require('builtin').oldfiles()<CR>]],"old files"},
	},
	["<space>"] = { builtin.buffers, "buffers" },
	t = { "<CMD>:ToggleTerm<CR>", "Toggle Terminal" },
}, { prefix = "<leader>" })
wk.register({
	r = { telescope.extensions.refactoring.refactors, "refactors" },
}, { prefix = "<leader>", mode = "nv" })
