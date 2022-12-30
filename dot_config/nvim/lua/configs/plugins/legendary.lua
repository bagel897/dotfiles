local opts = {
	autocmds = {
		{ name = "YankHighlight", { "TextYankPost ", vim.highlight.on_yank } },
	},
}
return {
	"mrjones2014/legendary.nvim",
	config = function()
		require("legendary").setup(opts)
	end,
}
