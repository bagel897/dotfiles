return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"lukas-reineke/lsp-format.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		-- local ts = {}
		-- ts.filetypes = { "typescript", "javascript" }
		-- ts.generator = {
		-- 	fn = function(_params)
		-- 		return require("typescript.extensions.null-ls.code-actions")
		-- 	end,
		-- }
		local sources = {
			-- null_ls.builtins.formatting.clang_format,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.diagnostics.rstcheck,
			null_ls.builtins.formatting.prettier.with({ disabled_filetypes = { "typescript" } }),
			-- null_ls.builtins.formatting.joker,
			-- null_ls.builtins.diagnostics.clj_kondo,
			null_ls.builtins.formatting.cljstyle,
			-- null_ls.builtins.code_actions.gitsigns,
			-- null_ls.builtins.diagnostics.gitlint,
			-- null_ls.builtins.diagnostics.luacheck,
			-- null_ls.builtins.diagnostics.pylint,
			null_ls.builtins.code_actions.refactoring,
			-- ts,
			-- null_ls.builtins.formatting.black,
			-- Black can be finnicky on the lsp side so I use Null to back it up
		}

		require("null-ls").setup({
			sources = sources,
			on_attach = require("configs.on_attach_no_ih"),
		})
	end,
	event = "BufReadPost",
}
