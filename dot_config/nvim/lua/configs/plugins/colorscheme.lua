return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	opts = {
		flavour = "mocha",
		integrations = {
			cmp = true,
			gitsigns = true,
			lsp_saga = true,
			lsp_trouble = true,
			markdown = true,
			mason = true,
			neogit = true,
			neotest = true,
			neotree = true,
			noice = true,
			notify = true,
			telescope = true,
			treesitter = true,
			ts_rainbow = true,
			which_key = true,
			leap = true,
			indent_blankline = {
				enabled = true,
				colored_indent_levels = true,
			},
			dap = {
				enabled = true,
				enable_ui = true, -- enable nvim-dap-ui
			},
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
				},
			},
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
