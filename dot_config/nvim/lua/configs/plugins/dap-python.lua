return {
	"mfussenegger/nvim-dap-python",
	opts = "python",
	keys = {
		{
			"<leader>dds",
			function()
				require("dap-python").debug_selection()
			end,
			desc = "debug selection python",
		},
	},
	ft = "python",
}
