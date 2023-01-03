return {
	"simrat39/rust-tools.nvim",
	config = function()
		local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
		local on_attach = require("configs.on_attach")
		local on_attach_ih = function(c, b)
			require("inlay-hints").on_attach(c, b)
			on_attach(c, b)
		end
		local opts = {
			tools = {
				on_initialized = function()
					require("inlay-hints").set_all()
				end,
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
	dependencies = { "inlay-hints.nvim" },
	ft = "rust",
}
