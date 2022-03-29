-- local dap_install = require("dap-install")
--
-- dap_install.setup({
-- 	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
-- })
-- local dap_install = require("dap-install")
-- local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
--
-- for _, debugger in ipairs(dbg_list) do
-- 	dap_install.config(debugger)
-- end
-- local opts = { noremap = false, silent = true }
local wk = require("which-key")
local dap = require("dap")
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
}, { prefix = "<leader>" })
require("dap-python").setup("python")
-- local dap_install = require("dap-install")
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed
	name = "lldb",
			env = {
			LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
		},
}
dap.adapters.codelldb = function(on_adapter)
	local stdout = vim.loop.new_pipe(false)
	local stderr = vim.loop.new_pipe(false)

	-- CHANGE THIS!
	local cmd = "/home/bageljr/Downloads/extension/adapter/codelldb"

	local handle, pid_or_err
	local opts = {
		stdio = { nil, stdout, stderr },
		detached = true,
	}
	handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
		stdout:close()
		stderr:close()
		handle:close()
		if code ~= 0 then
			print("codelldb exited with code", code)
		end
	end)
	assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
	stdout:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			local port = chunk:match("Listening on port (%d+)")
			if port then
				vim.schedule(function()
					on_adapter({
						type = "server",
						host = "127.0.0.1",
						port = port,
					})
				end)
			else
				vim.schedule(function()
					require("dap.repl").append(chunk)
				end)
			end
		end
	end)
	stderr:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)
end
dap.configurations.cpp = {
	{
		name = "test file lldb",
		type = "lldb",
		program = "${workspaceFolder}/cpp.out",
		request = "launch",
		cwd = "${workspaceFolder}",
		stdio = { "${workspaceFolder}/input1", nil, nil },
		args = {},
	},
	{
		name = "Launch via codelldb",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		stdio = { "input.txt", nil, nil },
		cwd = "${workspaceFolder}",
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

require("dap.ext.vscode").load_launchjs()
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
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
require("nvim-dap-virtual-text").setup()
