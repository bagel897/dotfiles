return {
	"t-troebst/perfanno.nvim",
	config = function()
		local util = require("perfanno.util")
		local bgcolor = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg", "gui")
		require("perfanno").setup({
			line_highlights = util.make_bg_highlights(bgcolor, "#CC3300", 10),
			vt_highlight = util.make_fg_highlight("#CC3300"),
		})
	end,
	keys = {
		{ "<LEADER>plf", ":PerfLoadFlat<CR>" },
		{ "<LEADER>plg", ":PerfLoadCallGraph<CR>" },
		{ "<LEADER>plo", ":PerfLoadFlameGraph<CR>" },

		{ "<LEADER>pe", ":PerfPickEvent<CR>" },

		{ "<LEADER>pa", ":PerfAnnotate<CR>" },
		{ "<LEADER>pf", ":PerfAnnotateFunction<CR>" },
		{ "<LEADER>pa", ":PerfAnnotateSelection<CR>" },

		{ "<LEADER>pt", ":PerfToggleAnnotations<CR>" },

		{ "<LEADER>ph", ":PerfHottestLines<CR>" },
		{ "<LEADER>ps", ":PerfHottestSymbols<CR>" },
		{ "<LEADER>pc", ":PerfHottestCallersFunction<CR>" },
		{ "<LEADER>pc", ":PerfHottestCallersSelection<CR>" },
	},
	enabled = true,
}
