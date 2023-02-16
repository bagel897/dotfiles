return {
	"akinsho/nvim-bufferline.lua",
	dependencies = { "catppuccin", "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {},
	config = function()
		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
				diagnostics_update_in_insert = true,
				show_buffer_close_icons = true,
				separator_style = "slant",
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
			},
		})
    end,
}
