local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local packer = require("packer")
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
		prompt_border = "single",
	},
	git = {
		clone_timeout = 6000, -- seconds
	},
	auto_clean = true,
	compile_on_sync = true,
})
return require("packer").startup({
	function(use)
		use({
			"kyazdani42/nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup({ default = true })
			end,
		})
		use({ "tpope/vim-sleuth" })
		use({
			"ethanholz/nvim-lastplace",
			config = function()
				require("nvim-lastplace").setup({})
			end,
		})
		use({
			"ellisonleao/glow.nvim",
			ft = { "markdown" },
			config = function()
				vim.keymap.set("n", "<leader>p", ":Glow<CR>")
			end,
		})
		use({
			"mfussenegger/nvim-jdtls",
		})
		use({
			"pixelneo/vim-python-docstring",
			config = function()
				vim.g.python_style = "google"
			end,
		})
		use({
			"rcarriga/nvim-notify",
			config = function()
				vim.notify = require("notify")
			end,
		})
		use({
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
			config = function()
				require("configs/neo-tree")
			end,
		})
		use({
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup({ sources = { ltex = { ignore = true } } })
			end,
		})
		use({
			"stevearc/dressing.nvim",
			config = function()
				require("dressing").setup({})
			end,
		})
		use({
			"mrjones2014/legendary.nvim",
			config = function()
				require("configs/legendary")
			end,
		})
		use({
			"romgrk/barbar.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("bufferline").setup({ auto_hide = true })
			end,
		})
		use({
			"glepnir/dashboard-nvim",
			config = function()
				local home = os.getenv("HOME")
				local db = require("dashboard")
				db.preview_file_path = home .. "/.config/nvim/static/neovim.cat"
				db.preview_file_height = 12
				db.preview_file_width = 80
				db.custom_center = {
					{
						icon = "  ",
						desc = "Recently laset session                  ",
						shortcut = "SPC s l",
						action = "SessionLoad",
					},
					{
						icon = "  ",
						desc = "Find  File                              ",
						action = "Telescope find_files find_command=rg,--hidden,--files",
						shortcut = "SPC f f",
					},
					{
						icon = "  ",
						desc = "Open Personal dotfiles                  ",
						action = "Telescope dotfiles path=" .. home .. "/.config",
						shortcut = "SPC f d",
					},
				}
			end,
		})
		use({ "wbthomason/packer.nvim", opt = false })
		use({
			"TimUntersberger/neogit",
			requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
			config = function()
				require("neogit").setup({ integrations = { diffview = true } })
			end,
		})
		use({
			"t-troebst/perfanno.nvim",
			config = function()
				local util = require("perfanno.util")
				local bgcolor = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg", "gui")
				require("perfanno").setup({
					line_highlights = util.make_bg_highlights(bgcolor, "#CC3300", 10),
					vt_highlight = util.make_fg_highlight("#CC3300"),
				})
			end,
			disable = true,
		})
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup({})
			end,
		})
		use({
			"nvim-telescope/telescope.nvim",
			"gbrlsnchs/telescope-lsp-handlers.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			config = function()
				require("configs/telescope")
			end,
			requires = { { "nvim-lua/plenary.nvim" } },
		})
		use({
			"Mofiqul/adwaita.nvim",
			"folke/tokyonight.nvim",
			"olimorris/onedarkpro.nvim",
			config = function() end,
		})
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				local navic = require("nvim-navic")
				require("lualine").setup({
					options = {
						globalstatus = true,
					},
					extensions = { "nvim-tree", "quickfix", "fugitive", "toggleterm", "symbols-outline" },
					sections = {
						lualine_c = { { "filename", path = 1 }, { navic.get_location, cond = navic.is_available } },
					},
				})
			end,
		})
		-- -- Add indentation guides even on blank lines
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("indent_blankline").setup({
					show_current_context = true,
					show_current_context_start = true,
				})
				--Map blankline
				vim.g.indent_blankline_char = "┊"
				vim.g.indent_blankline_filetype_exclude = { "help", "packer", "dashboard" }
				vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
				vim.g.indent_blankline_show_trailing_blankline_indent = false
			end,
		})
		-- Add git reoptionslated info in the signs columns and popups
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("gitsigns").setup({})
			end,
		})
		-- Highlight, edit, and navigate code using a fast incremental parsing library
		use({
			"nvim-treesitter/nvim-treesitter",
			require = { "nvim-treesitter/nvim-treesitter-textobjects" },
			run = ":TSUpdate",
			config = function()
				require("configs/treesitter")
			end,
		})
		use({
			"luukvbaal/stabilize.nvim",
			config = function()
				require("stabilize").setup()
			end,
		})
		use({
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/nvim-cmp",
			"rcarriga/cmp-dap",
			"L3MON4D3/LuaSnip",
			"davidsierradz/cmp-conventionalcommits",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
			"petertriho/cmp-git",
			"rafamadriz/friendly-snippets",
			requires = { "nvim-lua/plenary.nvim" },
		})
		use({
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			run = ":MasonToolsUpdate",
		})
		use({
			"neovim/nvim-lspconfig",
			"jose-elias-alvarez/null-ls.nvim",
			"p00f/clangd_extensions.nvim",
			"kosayoda/nvim-lightbulb",
			config = function()
				require("configs/lsp")
			end,
		})
		use({
			"nvim-treesitter/nvim-tree-docs",
			requires = "nvim-treesitter/nvim-treesitter",
			config = function()
				require("nvim-treesitter.configs").setup({
					tree_docs = { enable = true },
				})
			end,
			disabled = true,
		})
		-- use({
		--
		-- 	"ms-jpq/coq_nvim",
		-- 	"ms-jpq/coq.artifacts",
		-- 	"ms-jpq/coq.thirdparty",
		-- 	config = function()
		-- 		vim.g.coq_settings = { auto_start = "shut-up", xdg = true }
		-- 		require("coq_3p")({
		--
		-- 			{ src = "nvimlua", short_name = "nLUA", conf_only = true },
		-- 			{ src = "dap" },
		-- 		})
		-- 	end,
		-- 	run = ":COQDeps",
		-- })
		use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use({
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"nvim-telescope/telescope-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
			config = function()
				require("configs/dap")
			end,
		})
		use({
			"windwp/nvim-autopairs",
			config = function()
				local npairs = require("nvim-autopairs")
				npairs.setup({})
			end,
		})

		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup({})
			end,
			opt = false,
		})

		use({
			"petertriho/nvim-scrollbar",
			config = function()
				require("scrollbar").setup()
			end,
		})
		-- use({ "sidebar-nvim/sidebar.nvim", "sidebar-nvim/sections-dap" })
		use({
			"lukas-reineke/lsp-format.nvim",
			config = function()
				require("lsp-format").setup({})
			end,
		})
		use({
			"ggandor/leap.nvim",
			config = function()
				require("leap").set_default_keymaps()
			end,
		})
		use({
			"simrat39/rust-tools.nvim",
			config = function()
				local opts = {
					dap = {
						adapter = require("rust-tools.dap").get_codelldb_adapter(
							"/usr/bin/codelldb",
							"/usr/lib/libldb.so"
						),
					},
				}

				require("rust-tools").setup(opts)
			end,
		})
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("configs/trouble")
			end,
		})
		use({
			"akinsho/toggleterm.nvim",
			branch = "main",
			config = function()
				require("toggleterm").setup({})
			end,
			commands = ":ToggleTerm",
		})
		-- use({
		-- 	"neomake/neomake",
		-- 	config = function()
		-- 		vim.cmd([[call neomake#configure#automake('w')]])
		-- 	end,
		-- })
		use({
			"p00f/cphelper.nvim",
			config = function()
				vim.g.cphlang = "python"
				vim.g.cpp_compile_command = "g++ -g solution.cpp -o solution"
			end,
		})
		use({
			"narutoxy/dim.lua",
			requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
			config = function()
				require("dim").setup({})
			end,
		})
		use({ "lewis6991/impatient.nvim" })
		use({ "nvim-lua/popup.nvim", requires = { "nvim-lua/plenary.nvim" } })
		use({
			"ThePrimeagen/git-worktree.nvim",
			config = function()
				require("telescope").load_extension("git_worktree")
			end,
		})
		use({
			"simrat39/symbols-outline.nvim",
		})
		use({
			"pwntester/octo.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"kyazdani42/nvim-web-devicons",
			},
			config = function()
				require("octo").setup()
			end,
		})
		use({
			"someone-stole-my-name/yaml-companion.nvim",
			requires = {
				{ "neovim/nvim-lspconfig" },
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope.nvim" },
			},
			config = function()
				require("telescope").load_extension("yaml_schema")
			end,
		})
		use({
			"nvim-neotest/neotest",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-neotest/neotest-python",
			},
			config = function()
				require("neotest").setup({
					adapters = {
						require("neotest-python")({
							dap = { justMyCode = false },
						}),
						-- require("neotest-plenary"),
						-- require("neotest-vim-test")({
						-- 	ignore_file_types = { "python", "vim", "lua" },
						-- }),
					},
				})
			end,
		})
		use({
			"SmiteshP/nvim-navic",
			requires = "neovim/nvim-lspconfig",
			config = function()
				local navic = require("nvim-navic")
				navic.setup({ highlight = true })
				vim.g.navic_silence = true
			end,
		})
		use({
			"ray-x/lsp_signature.nvim",
		})
		use({
			"lewis6991/spellsitter.nvim",
			config = function()
				require("spellsitter").setup()
			end,
		})
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
})
