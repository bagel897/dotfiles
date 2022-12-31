return {
	"RubixDev/mason-update-all",
	config = function()
		require("mason-update-all").setup()
	end,
	build = function()
		vim.cmd("PylspInstall pyls-isort pylsp-rope pylsp-mypy python-lsp-black")

		vim.cmd(":MasonUpdateAll <CR>")
	end,
	cmd = "MasonUpdateAll",
}
