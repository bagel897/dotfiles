return {
	"petertriho/nvim-scrollbar",
	dependencies = {

		"kevinhwang91/nvim-hlslens",
		"lewis6991/gitsigns.nvim",
	},
	config = function()
		require("scrollbar").setup()
		require("scrollbar.handlers.search").setup({
			-- hlslens config overrides
		})

		require("scrollbar.handlers.gitsigns").setup()
	end,
	event = "BufReadPost",
}
