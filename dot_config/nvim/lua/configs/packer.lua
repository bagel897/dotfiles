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
		})
		use({
			"romgrk/barbar.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
		})
		use({
			"glepnir/dashboard-nvim",
			config = function()
				vim.g.dashboard_default_executive = "telescope"
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
		use("t-troebst/perfanno.nvim")
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
			requires = { { "nvim-lua/plenary.nvim" } },
		})
		use({
			"folke/tokyonight.nvim",
			config = function()
				vim.g.tokyonight_style = "night"
			end,
		})
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("lualine").setup({
					options = {
						theme = "tokyonight",
						globalstatus = true,
					},
					extensions = { "nvim-tree", "quickfix", "fugitive", "toggleterm", "symbols-outline" },
					sections = { lualine_c = { { "filename", path = 1 } } },
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
		})
		use("rafamadriz/friendly-snippets")
		use({ "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" })
		use({
			"neovim/nvim-lspconfig",
			"jose-elias-alvarez/null-ls.nvim",
			"p00f/clangd_extensions.nvim",
			-- "ms-jpq/coq_nvim",
			-- "ms-jpq/coq.artifacts",
			-- "ms-jpq/coq.thirdparty",
			"kosayoda/nvim-lightbulb",
			-- config = function()
			-- 	vim.g.coq_settings = { auto_start = "shut-up", xdg = true }
			-- 	require("coq_3p")({
			--
			-- 		{ src = "nvimlua", short_name = "nLUA", conf_only = true },
			-- 		{ src = "dap" },
			-- 	})
			-- end,
			-- run = ":COQDeps",
		})
		use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use({
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"nvim-telescope/telescope-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
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
			"ThePrimeagen/refactoring.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
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
			"nathom/filetype.nvim",
			config = function()
				require("filetype").setup({})
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
				"nvim-neotest/neotest-python"
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
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
})
