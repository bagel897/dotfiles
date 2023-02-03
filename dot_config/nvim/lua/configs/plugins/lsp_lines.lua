return {
	name = "lsp_lines.nvim",
	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	config = function(opts)
		require("lsp_lines").setup(opts)
	end,
	event = "BufReadPost",
}
