local cindent = function()
	vim.o.shiftwidth = 2
	vim.o.tabstop = 2
	vim.o.cindent = true
end
require("legendary").setup({
	auto_register_which_key = true,
	autocmds = {
		{ name = "YankHighlight", { "TextYankPost ", vim.highlight.on_yank } },
		{
			name = "packer_user_config",
			{ "BufWritePost", "source <afile> | PackerCompile", opts = { pattern = "*/configs/packer.lua" } },
		},
		{ name = "SetCIndent", { "FileType c", cindent } },
		{
			name = "Format",
			{
				"BufWritePost",
				vim.lsp.buf.formatting_seq_sync,
			},
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
