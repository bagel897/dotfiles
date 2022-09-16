require("dap-python").setup("python")
require("dap-python").test_runner = "pytest"
local dap = require("dap")
local cmd = "/usr/bin/codelldb"
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		-- CHANGE THIS to your path!
		command = "/home/bageljr/.local/share/nvim/mason/bin/codelldb",
		args = { "--port", "${port}" },

		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}
dap.configurations.cpp = {
	-- {
	-- 	name = "competitive test",
	-- 	type = "lldb",
	-- 	request = "launch",
	-- 	program = "${workspaceFolder}/solution",
	-- 	cwd = "${workspaceFolder}",
	-- 	stdio = {
	-- 		function()
	-- 			choices = require("plenary.scandir").scan_dir(vim.fn.getcwd())
	-- 			vim.ui.select(choices({ prompt = "select a test case" }), function(choice)
	-- 				return choices[choice]
	-- 			end)
	-- 			return
	-- 		end,
	-- 		nil,
	-- 		nil,
	-- 	},
	-- 	args = {},
	-- },
	-- {
	-- 	name = "competitive test case",
	-- 	type = "lldb",
	-- 	request = "launch",
	-- 	program = "${workspaceFolder}/solution",
	-- 	cwd = "${workspaceFolder}",
	-- 	stdio = function()
	-- 		return { "${workspaceFolder}/input" .. vim.ui.input("which case number"), nil, nil }
	-- 	end,
	-- 	args = {},
	-- },
	{
		name = "competitive test case 1",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/solution",
		cwd = "${workspaceFolder}",
		stdio = { "${workspaceFolder}/input1", nil, nil },
		args = {},
		stopOnEntry = false,
	},
	{
		name = "competitive test case 2",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/solution",
		cwd = "${workspaceFolder}",
		stdio = { "${workspaceFolder}/input2", nil, nil },
		args = {},
		stopOnEntry = false,
	},
	{
		name = "competitive test case 3",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/solution",
		cwd = "${workspaceFolder}",
		stdio = { "${workspaceFolder}/input3", nil, nil },
		args = {},
		stopOnEntry = false,
	},
	{
		name = "competitive test case 4",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/solution",
		cwd = "${workspaceFolder}",
		stdio = { "${workspaceFolder}/input4", nil, nil },
		args = {},
		stopOnEntry = false,
	},
	{
		name = "competitive test case 5",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/solution",
		cwd = "${workspaceFolder}",
		stdio = { "${workspaceFolder}/input5", nil, nil },
		args = {},
		stopOnEntry = false,
	},
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
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
-- dap.adapters.python = {
--   type = 'executable';
--   command = '/usr/bin/python';
--   args = { '-m', 'debugpy.adapter' };
-- }
-- dap.configurations.python = {
--   {
--     -- The first three options are required by nvim-dap
--     type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
--     request = 'launch';
--     name = "Launch file";
--
--     -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
--
--     program = "${file}"; -- This configuration will launch the current file if used.
--     pythonPath = function()
--       -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
--       -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
--       -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
--       local cwd = vim.fn.getcwd()
--       if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
--         return cwd .. '/venv/bin/python'
--       elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
--         return cwd .. '/.venv/bin/python'
--       else
--         return '/usr/bin/python'
--       end
--     end;
--   },
-- }

require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "c", "cpp" } })
require("dapui").setup({})
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
require("nvim-dap-virtual-text").setup()
