return {
	"romgrk/barbar.nvim",
	dependencies = { "kyazdani42/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({ auto_hide = true })
	end,
}
