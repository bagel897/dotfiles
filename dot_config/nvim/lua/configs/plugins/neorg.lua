return {
	"nvim-neorg/neorg",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.norg.dirman"] = {
					config = {
						workspaces = {
							notes = "~/Documents/notes",
						},
					},
				},
				["core.norg.concealer"] = {},
				["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
			},
		})
	end,
	enabled = true,
	ft = "norg",
	run = ":Neorg sync-parsers", -- This is the important bit!,
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter" },
}
