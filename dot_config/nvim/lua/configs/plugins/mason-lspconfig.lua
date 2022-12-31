return {

	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"mason.nvim",
		"nvim-lspconfig",
	},
	config = function()
		require("mason-lspconfig").setup({
			automatic_installation = true,
		})
	end,
	build = function()
		vim.cmd("PylspInstall pyls-isort pylsp-rope pylsp-mypy python-lsp-black")
	end,
	event = "VeryLazy",
}
