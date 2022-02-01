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
local opts = {noremap = false, silent = true}

vim.api.nvim_buf_set_keymap(0, "n", "<Leader>dn", '<cmd>lua require"dap".step_over()<CR>', opts)
vim.api.nvim_buf_set_keymap(0, "n", "<Leader>ds", '<cmd>lua require"dap".step_into()<CR>', opts)
vim.api.nvim_buf_set_keymap(0, "n", "<Leader>do", '<cmd>lua require"dap".step_out()<CR>', opts)
vim.api.nvim_buf_set_keymap(0, "n", "<Leader>db", '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
-- vim.api.nvim_buf_set_keymap( 0, 'n', '<Leader>dB',
--        '<cmd>lua require"dap".set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>', opts)
vim.api.nvim_buf_set_keymap(0, "n", "<Leader>dc", '<cmd>lua require"dap".continue()<CR>', opts)

vim.api.nvim_buf_set_keymap(0, "n", "<Leader>dr", '<cmd>lua require"dap".run_last()<CR>', opts)

require("dap-python").setup("/usr/bin/python")
local dap = require("dap")
dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode", -- adjust as needed
  name = "lldb"
}
dap.configurations.cpp = {
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
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false
  }
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
table.insert(
  require("dap").configurations.cpp,
  {
    name = "compile and launch",
    type = "lldb",
    program = "/tmp/debug",
    request = "launch",
    stopOnEntry = false,
    initCommands = "g++ -g -o /tmp/debug ${file}",
    args = {},
    runInTerminal = false
  }
)
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

require("dapui").setup()
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
require("dap.ext.vscode").load_launchjs()
