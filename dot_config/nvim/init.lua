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

--Remap space as leader key
--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 1 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 1 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- local sidebar = require("sidebar-nvim")
-- local opts = {
--   open = true,
--   side = "right",
--   sections = {
--         "git",
--         "diagnostics",
--         "symbols",
--         require("dap-sidebar-nvim.breakpoints")
--   },
--   dap = {
--         breakpoints = {
--             icon = "🔍"
--         }
--   },
--   disable_closing_prompt = true
-- }
-- sidebar.setup(opts)
vim.keymap.set("n", "q", [[<cmd>q<CR>]])
vim.o.autoread = true
vim.cmd([[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif]])
vim.cmd(
	[[autocmd FileChangedShellPost *\ echohl WarningMsg | lua vim.notify("File changed on disk. Buffer reloaded.") | echohl None]]
)
require("configs/packer")
vim.o.completeopt = "menu,menuone,noselect"
require("configs/keymaps")
require("configs/treesitter")
require("configs/dap")
-- vim.o.splitkeep = screen
