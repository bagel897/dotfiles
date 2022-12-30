return {
	"nvim-neorg/neorg",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.norg.concealer"] = {},
				["core.integrations.nvim-cmp"] = {},
			},
		})
	end,
	enabled = false,
	dependencies = { "nvim-lua/plenary.nvim" },
}
