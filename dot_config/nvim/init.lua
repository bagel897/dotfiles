vim.opt.termguicolors = true
require("configs/packer")
require("impatient")
require("configs/lsp")
require("configs/dap")
require("configs/telescope")
require("configs/cmp")
require("configs/splits")
--Set highlight on search
vim.o.hlsearch = true
vim.o.clipboard = "unnamedplus"
--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true
vim.o.autowrite = true
--Case insensitive searching UNLESS /C or capital in search

vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 251
vim.wo.signcolumn = "yes"

--Set colorscheme
vim.o.termguicolors = true
vim.cmd([[colorscheme tokyonight]])

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 1 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 1 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer", "dashboard" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

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
vim.api.nvim_set_keymap("n", "q", [[<cmd> q <CR>]], { noremap = true, silent = true })

local util = require("perfanno.util")
local bgcolor = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg", "gui")
require("perfanno").setup({
	line_highlights = util.make_bg_highlights(bgcolor, "#CC3300", 10),
	vt_highlight = util.make_fg_highlight("#CC3300"),
})
require("configs/legendary")
