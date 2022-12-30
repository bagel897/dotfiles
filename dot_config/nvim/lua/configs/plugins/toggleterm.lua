return {
	"akinsho/toggleterm.nvim",
	branch = "main",
	config = function()
		require("toggleterm").setup({})
	end,
	keys = { { "<leader>t", "<CMD>:ToggleTerm<CR>", desc = "Toggle Terminal" } },
	lazy = true,
}
