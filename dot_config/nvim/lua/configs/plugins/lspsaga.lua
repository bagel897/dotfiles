return {
	"glepnir/lspsaga.nvim",
	branch = "main",
	config = function()
		require("lspsaga").setup({
			symbol_in_winbar = { enable = true },

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
