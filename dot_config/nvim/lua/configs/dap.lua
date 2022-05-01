require("dap-python").setup("python")
require("dap-python").test_runner = "pytest"
local dap = require("dap")
local cmd = "/usr/bin/codelldb"

dap.adapters.lldb = function(on_adapter)
	-- This asks the system for a free port
	local tcp = vim.loop.new_tcp()
	tcp:bind("127.0.0.1", 0)
	local port = tcp:getsockname().port
	tcp:shutdown()
	tcp:close()

	-- Start codelldb with the port
	local stdout = vim.loop.new_pipe(false)
	local stderr = vim.loop.new_pipe(false)
	local opts = {
		stdio = { nil, stdout, stderr },
		args = { "--port", tostring(port) },
	}
	local handle
	local pid_or_err
	handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
		stdout:close()
		stderr:close()
		handle:close()
		if code ~= 0 then
			print("codelldb exited with code", code)
		end
	end)
	if not handle then
		vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
		stdout:close()
		stderr:close()
		return
	end
	vim.notify("codelldb started. pid=" .. pid_or_err)
	stderr:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)
	local adapter = {
		type = "server",
		host = "127.0.0.1",
		port = port,
	}
	-- 💀
	-- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
	-- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
	vim.defer_fn(function()
		on_adapter(adapter)
	end, 500)
end
dap.configurations.cpp = {
	{
		name = "test1",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/solution",
		cwd = "${workspaceFolder}",
		stdio = { "${workspaceFolder}/input1", nil, nil },
		args = {},
	},
	{
		name = "test2",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/solution",
		cwd = "${workspaceFolder}",
		stdio = { "${workspaceFolder}/input2", nil, nil },
		args = {},
	},
	{
		name = "test3",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/solution",
		cwd = "${workspaceFolder}",
		stdio = { "${workspaceFolder}/input3", nil, nil },
		args = {},
	},
	{
		name = "test4",
		type = "lldb",
		request = "launch",
		program = "${workspaceFolder}/solution",
		cwd = "${workspaceFolder}",
		stdio = { "${workspaceFolder}/input4", nil, nil },
		args = {},
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
