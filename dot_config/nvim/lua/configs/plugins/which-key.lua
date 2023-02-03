return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = { spelling = true },
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register({
			mode = { "n", "v" },
			["g"] = { name = "+goto" },
			["gz"] = { name = "+surround" },
			["]"] = { name = "+next" },
			["["] = { name = "+prev" },
			["<leader><tab>"] = { name = "+tabs" },
			["<leader>b"] = { name = "+buffer" },
			["<leader>c"] = { name = "+code" },
			["<leader>q"] = { name = "+quit/session" },
			["<leader>sn"] = { name = "+noice" },
			["<leader>u"] = { name = "+ui" },
			["<leader>w"] = { name = "+workspace/worktree" },
			["<leader>x"] = { name = "+diagnostics/quickfix" },
			["<leader>f"] = { name = "+file/find" },
			["<leader>s"] = { name = "+search" },
			["<leader>d"] = { name = "+debug" },
			["<leader>h"] = { name = "+git" },
			["<leader>l"] = { name = "+lsp" },
			["<leader>p"] = { name = "+perfanno" },
		})
	end,
}
