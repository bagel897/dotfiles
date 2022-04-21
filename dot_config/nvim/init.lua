vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("configs/packer")
require("impatient")

--Set highlight on search
vim.o.hlsearch = true
vim.o.clipboard = "unnamedplus"
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
-- vim.o.filetype = "on"
--Save undo history
vim.opt.undofile = true
vim.o.autowriteall = true
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
--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 1 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 1 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

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
vim.keymap.set("n", "q", [[<cmd>q<CR>]])

-- local util = require("perfanno.util")
-- local bgcolor = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg", "gui")
-- require("perfanno").setup({
-- 	line_highlights = util.make_bg_highlights(bgcolor, "#CC3300", 10),
-- 	vt_highlight = util.make_fg_highlight("#CC3300"),
-- })
require("configs/lsp")
require("configs/dap")
require("configs/telescope")
require("configs/splits")
require("configs/legendary")
require("configs/keymaps")
require("configs/treesitter")
require("configs/neo-tree")
require("configs/trouble")
require("configs/cmp")
vim.o.mouse = "a"
