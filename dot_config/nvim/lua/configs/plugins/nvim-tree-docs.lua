return {
	"nvim-treesitter/nvim-tree-docs",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			tree_docs = { enable = true },
		})
	end,
}
