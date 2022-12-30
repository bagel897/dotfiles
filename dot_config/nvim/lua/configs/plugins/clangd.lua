return {
	"p00f/clangd_extensions.nvim",
	config = function()
		require("clangd_extensions").setup({
			server = {
				cmd = {
					"clangd",
					"--background-index",
					"-j=12",
					"--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
					"--clang-tidy",
					"--all-scopes-completion",
					"--cross-file-rename",
					"--completion-style=detailed",
					"--header-insertion-decorators",
					"--header-insertion=iwyu",
					"--pch-storage=memory",
				},
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				on_attach = require("configs.on_attach"),
			},
		})
	end,
}
