return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"haydenmeade/neotest-jest",
		"rouge8/neotest-rust",
		"nvim-neotest/neotest-vim-test",
		"vim-test/vim-test",
	},
	config = function()
		local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb"
		require("neotest").setup({
			consumers = {
				overseer = require("neotest.consumers.overseer"),
			},
			adapters = {
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function(path)
						return vim.fn.getcwd()
					end,
				}),

				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-rust")({
					args = { "--no-capture" },
					dap_adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				}),
				-- require("neotest-plenary"),
				require("neotest-vim-test")({
					ignore_file_types = { "python", "vim", "rust" },
				}),
			},
		})
	end,
	lazy = true,
}
