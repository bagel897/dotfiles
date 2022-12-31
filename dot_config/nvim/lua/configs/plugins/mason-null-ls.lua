return {
	"jayp0521/mason-null-ls.nvim",
	config = function()
		require("mason-null-ls").setup({
			automatic_installation = true,
			automatic_setup = true,
		})
	end,
	event = "BufReadPost",
}
