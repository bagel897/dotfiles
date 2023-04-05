return {
	"mxsdev/nvim-dap-vscode-js",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	ft = { "javascript", "typescript" },
	config = function()
		require("dap-vscode-js").setup({
			debugger_cmd = { "js-debug-adapter" },
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		})
		for _, language in ipairs({ "typescript", "javascript" }) do
			require("dap").configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end
		local dap = require("dap")
		dap.adapters.chrome = dap.adapters["pwa-chrome"]
		local mappings = { chrome = { "typescript", "javascript" } }
		mappings["pwa-chrome"] = mappings["chrome"]
		require("dap.ext.vscode").load_launchjs(nil, mappings)
	end,
	enabled = false,
}
