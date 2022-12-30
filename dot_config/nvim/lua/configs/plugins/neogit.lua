return {
	"TimUntersberger/neogit",
	dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
	config = function()
		require("neogit").setup({ integrations = { diffview = true } })
	end,
}
