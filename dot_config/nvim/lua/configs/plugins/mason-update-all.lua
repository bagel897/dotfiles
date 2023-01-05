return {
	"RubixDev/mason-update-all",
	config = function()
		require("mason-update-all").setup()
		vim.api.nvim_create_user_command("MasonUpdateLSP", function()
			vim.cmd("MasonUpdateAll")
			vim.cmd("PylspInstall pyls-isort pylsp-rope pylsp-mypy python-lsp-black python-lsp-ruff")
		end, {})
	end,
	event = "VeryLazy",
	cmd = "MasonUpdateAll",
}
