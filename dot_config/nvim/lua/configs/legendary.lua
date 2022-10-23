require("legendary").setup({
	autocmds = {
		{ name = "YankHighlight", { "TextYankPost ", vim.highlight.on_yank } },
		{
			name = "packer_user_config",
			{ "BufWritePost", "source <afile> | PackerCompile", opts = { pattern = "*/configs/packer.lua" } },
		},
	},
})
