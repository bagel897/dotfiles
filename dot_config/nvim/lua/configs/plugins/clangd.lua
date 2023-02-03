return {
	name = "clangd_extensions.nvim",
	url = "https://git.sr.ht/~p00f/clangd_extensions.nvim/",
	ft = { "c", "cpp" },
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
					"--completion-style=detailed",
					"--header-insertion-decorators",
					"--header-insertion=iwyu",
					"--pch-storage=memory",
				},
				capabilities = require("configs.capabilities").default_capabilities(),
				on_attach = require("configs.on_attach_no_ih"),
			},
		})
	end,
}
