vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--Set highlight on search
vim.o.hlsearch = true
vim.o.clipboard = "unnamedplus"
vim.o.guifont = "FiraCode NF"
vim.g.adwaita_darker = true
vim.cmd("set spell")
--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
-- vim.o.breakindent = true
-- vim.o.tabstop = 4
-- vim.o.shiftwidth = 4
-- vim.o.expandtab = true
-- vim.o.cindent = true
--Save undo history
vim.opt.undofile = true
vim.o.autowriteall = true
--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 251
vim.wo.signcolumn = "yes"

vim.o.autoread = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.cursorline = true
vim.o.smartindent = true
vim.o.foldlevel = 99
--Remap space as leader key
--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 1 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 1 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "q", [[<cmd>q<CR>]])
vim.cmd([[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif]])
vim.cmd(
	[[autocmd FileChangedShellPost *\ echohl WarningMsg | lua vim.notify("File changed on disk. Buffer reloaded.") | echohl None]]
)
vim.o.completeopt = "menu,menuone,noselect"
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
})
vim.api.nvim_create_augroup("neogit-additions", {})
vim.api.nvim_create_autocmd("FileType", {
	group = "neogit-additions",
	pattern = "NeogitCommitMessage",
	command = "silent! set filetype=gitcommit",
})
