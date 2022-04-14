vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n",'<leader>r',":NvimTreeRefresh<CR>",{noremap = true})
-- vim.api.nvim_set_keymap("n",'<leader>n',":NvimTreeFindFile<CR>",{noremap = true})
require("nvim-tree").setup({
	auto_close = true,
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
	},
	filters = {
		dotfiles = false,
	},
	view = {
		auto_resize = true,
	},
})
