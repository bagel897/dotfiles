return {
	"glepnir/lspsaga.nvim",
	branch = "main",
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = { enable = true },
			ui = {
				colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
				kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
			},

			-- your configuration
		})
	end,
	keys = { {
		"<leader>s",
		"<cmd>Lspsaga outline<CR>",
		desc = "symbols outline",
	} },
	cmd = { "Lspsaga" },
	event = "BufRead",
}
