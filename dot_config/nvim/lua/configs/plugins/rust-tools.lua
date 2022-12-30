return {
	"simrat39/rust-tools.nvim",
	config = function()
		local opts = {
			dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter("/usr/bin/codelldb", "/usr/lib/libldb.so"),
			},
		}

		require("rust-tools").setup(opts)
	end,
	ft = "rust",
}
