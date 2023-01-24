return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-treesitter/nvim-treesitter" },
	},
	config = function()
		require("refactoring").setup({})
		require("telescope").load_extension("refactoring")

		-- remap to open the Telescope refactoring menu in visual mode
	end,
	lazy = true,
}
