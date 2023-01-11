return {
	"romgrk/barbar.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({ auto_hide = true })
	end,
}
