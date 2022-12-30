return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("indent_blankline").setup({
			show_current_context = true,
			show_current_context_start = true,
		})
		--Map blankline
		vim.g.indent_blankline_char = "┊"
		vim.g.indent_blankline_filetype_exclude = { "help", "packer", "dashboard" }
		vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
		vim.g.indent_blankline_show_trailing_blankline_indent = false
	end,
}
