return {
	"smjonas/inc-rename.nvim",
	opts = true,
	keys = { {
		"<leader>lr",
		function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end,
		desc = "Rename",
		expr=true,
	} },
	cmd = "IncRename",
}
