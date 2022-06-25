require("legendary").setup({
	auto_register_which_key = true,
	autocmds = {
		{ name = "YankHighlight", { "TextYankPost ", vim.highlight.on_yank } },
		{
			name = "packer_user_config",
			{ "BufWritePost", "source <afile> | PackerCompile", opts = { pattern = "*/configs/packer.lua" } },
		},
		{
			name = "Lightbulb",
			{
				{ "CursorHold,CursorHoldI" },
				require("nvim-lightbulb").update_lightbulb,
			},
		},
	},
})
