return {
	"jayp0521/mason-nvim-dap.nvim",
	dependencies = {
		"mfussenegger/nvim-dap",
		"williamboman/mason.nvim",
	},
	config = function()
		local dap = require("dap")

		require("mason-nvim-dap").setup({
			ensure_installed = { "javadbg", "javatest" },
			automatic_installation = true,
			automatic_setup = true,
		})
	end,
	event = "VeryLazy",
}
