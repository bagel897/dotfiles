local config = function()
	local dap = require("dap")
	require("mason-nvim-dap").setup_handlers()
	local sign = vim.fn.sign_define
	sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
	sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
	sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
	dap.configurations.cpp = {
		{
			name = "Launch",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
		},
		{
			-- If you get an "Operation not permitted" error using this, try disabling YAMA:
			--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
			name = "Attach to process",
			type = "codelldb", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
			request = "attach",
			pid = require("dap.utils").pick_process,
			args = {},
		},
	}
	dap.configurations.c = dap.configurations.cpp
	dap.configurations.rust = dap.configurations.cpp

	dap.adapters.firefox = {
		type = "executable",
		command = "node",
		args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
	}
	dap.configurations.typescript = {
		{
			name = "Debug with Firefox",
			type = "firefox",
			request = "launch",
			reAttach = true,
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
		},
	}
	require("dap.ext.vscode").json_decode = require("json5").parse
	local mappings = { codelldb = { "c", "cpp" }, firefox = { "typescript", "javascript" } }

	require("dap.ext.vscode").load_launchjs(nil, mappings)
	local dapui = require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
		-- require("trouble").close()
		-- require("dap.repl").close()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
		-- require("dap").repl.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
	vim.cmd([[autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif]])
	require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
		sources = {
			{ name = "dap" },
		},
	})
end
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"Joakker/lua-json5",
			build = "./install.sh",
		},
		{ "overseer.nvim" },
		{ "rcarriga/nvim-dap-ui", opts = true },
		{
			"nvim-telescope/telescope-dap.nvim",
			config = function()
				require("telescope").load_extension("dap")
			end,
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = true,
		},
		{
			"jayp0521/mason-nvim-dap.nvim",
			opts = {
				ensure_installed = { "javadbg", "javatest", "codelldb", "python", "firefox" },
				automatic_installation = true,
				automatic_setup = true,
			},
		},
		"mortepau/codicons.nvim",
		"rcarriga/cmp-dap",
		{ "Weissle/persistent-breakpoints.nvim", opts = { load_breakpoints_event = { "BufReadPost" } } },
	},
	keys = {
		{ "<leader>dn", "<cmd>:DapStepOver<cr>", desc = "step over" },
		{ "<leader>ds", "<cmd>:DapStepInto<cr>", desc = "step into" },
		{ "<leader>do", "<cmd>:DapStepOut<cr>", desc = "step out" },
		{
			"<leader>do",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "run to cursor",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "toggle breakpoint ",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "continue",
		},
		{
			"<leader>dr",
			function()
				require("dap").run_last()
			end,
			desc = "run last",
		},
		{
			"<leader>dq",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "conditional breakpoint",
		},
		{
			"<leader>dx",
			function()
				require("dap").terminate()
			end,
			desc = "terminate",
		},
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "pause",
		},
	},
	config = config,
}
