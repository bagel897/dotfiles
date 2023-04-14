return {
	"simrat39/rust-tools.nvim",
	config = function()
		local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
		local on_attach_ih = require("configs.on_attach_ih")
		local opts = {
			tools = {
				inlay_hints = {
					auto = true,
				},
			},
			dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			},
			server = { on_attach = on_attach_ih },
		}

		require("rust-tools").setup(opts)
		vim.diagnostic.config({
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = true,
		})
	end,
	dependencies = {
		"nvim-dap",
	},
	ft = "rust",
}
