return {
	"simrat39/rust-tools.nvim",
	config = function()
		local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
		local on_attach = require("configs.on_attach")
		local on_attach_ih = function(c, b)
			on_attach(c, b, true)
		end
		local opts = {
			tools = {
				inlay_hints = {
					auto = false,
				},
			},
			dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			},
			server = { on_attach = on_attach_ih },
		}

		require("rust-tools").setup(opts)
	end,
	ft = "rust",
}
