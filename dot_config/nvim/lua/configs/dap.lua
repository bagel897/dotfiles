require("dap-python").setup("python")
require("dap-python").test_runner = "pytest"
local dap = require("dap")
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed
	name = "lldb",
}
dap.configurations.cpp = {
	{
		name = "test1",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/cpp.out",
		cwd = "${workspaceFolder}",
		args = { "<input1" },
		runInTerminal = true,
		postRunCommands = { "process handle -p true -s false -n false SIGWINCH" },
	},
	{
		name = "test2",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/cpp.out",
		cwd = "${workspaceFolder}",
		args = { "<input2" },
		runInTerminal = true,
		postRunCommands = { "process handle -p true -s false -n false SIGWINCH" },
	},
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
	{
		-- If you get an "Operation not permitted" error using this, try disabling YAMA:
		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		name = "Attach to process",
		type = "lldb", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
		request = "attach",
		pid = require("dap.utils").pick_process,
		args = {},
	},
}
dap.configurations.c = dap.configurations.cpp
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

require("dap.ext.vscode").load_launchjs(nil, { lldb = { "c", "cpp" } })
require("dapui").setup({
	tray = {
		-- elements = { "repl" },
		-- size = 10,
		-- position = "bottom", -- Can be "left", "right", "top", "bottom"
	},
})
local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
	require("trouble").close()
	-- require("dap.repl").close()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
	require("trouble").open()
	-- require("dap").repl.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
	require("trouble").open()
end
require("nvim-dap-virtual-text").setup()
