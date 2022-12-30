return {
	"narutoxy/dim.lua",
	dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
	config = function()
		require("dim").setup({})
	end,
	event = "VeryLazy",
}
