return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
		require("catppuccin").setup({
			integration = {
				dashboard = true,
				gitsigns = true,
				markdown = true,
				neotree = true,
				neogit = true,
				neotest = true,
				cmp = true,
				noice = true,
				treesitter = true,
				ts_rainbow = true,
				lsp_saga = true,
				telescope = true,
				which_key = true,
				leap = true,
				mason = true,
				notify = true,
				trouble = true,
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
		})
		vim.api.nvim_command("colorscheme catppuccin")
	end,
}
