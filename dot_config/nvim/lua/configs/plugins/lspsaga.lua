return {
	"glepnir/lspsaga.nvim",
	branch = "main",
	config = function()
		local saga = require("lspsaga")

		saga.init_lsp_saga({
			symbol_in_winbar = { enable = true },
			-- your configuration
		})
	end,
	keys = { {
		"<leader>s",
		"<cmd>LSoutlineToggle<CR>",
		desc = "symbols outline",
	} },
}
