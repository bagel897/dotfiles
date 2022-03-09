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

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost config/packer.lua source <afile> | PackerCompile
  augroup end
]])
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
		use("tpope/vim-sleuth")
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
		-- use({
		-- 	"mrjones2014/legendary.nvim",
		-- 	config = function()
		-- 		require("legendary").setup({ auto_register_which_key = true })
		-- 	end,
		-- })
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
		use("wbthomason/packer.nvim")
		use("tpope/vim-fugitive") -- Git commands in nvim
		use("tpope/vim-rhubarb") -- Fugitive-companion to interact with github
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
		use("mjlbach/onedark.nvim") -- Theme inspired by Automatic
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("lualine").setup({
					options = {
						icons_enabled = true,
						theme = "onedark",
						component_separators = "|",
						section_separators = "",
					},
					extensions = { "nvim-tree", "fzf", "quickfix", "fugitive" },
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
			config = function()
				require("configs/treesitter")
			end,
		})
		--   use({
		-- "neovim/nvim-lspconfig",
		-- "hrsh7th/cmp-nvim-lsp",
		-- "hrsh7th/cmp-buffer",
		-- "hrsh7th/cmp-path",
		-- "hrsh7th/cmp-cmdline",
		-- "hrsh7th/cmp-nvim-lsp-signature-help",
		-- "hrsh7th/nvim-cmp",
		-- "L3MON4D3/LuaSnip",
		-- "saadparwaiz1/cmp_luasnip",
		-- "onsails/lspkind-nvim",
		--   })
		use({
			"neovim/nvim-lspconfig",
			"jose-elias-alvarez/null-ls.nvim",
			"p00f/clangd_extensions.nvim",
			"ms-jpq/coq_nvim",
			"ms-jpq/coq.artifacts",
			"ms-jpq/coq.thirdparty",
			"kosayoda/nvim-lightbulb",
			config = function()
				vim.g.coq_settings = { auto_start = "shut-up", xdg = true }
				require("coq_3p")({

					{ src = "nvimlua", short_name = "nLUA", conf_only = true },
					{ src = "dap" },
				})
			end,
			run = ":COQDeps",
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
				require("nvim-autopairs").setup({})
			end,
		})

		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup({})
			end,
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
		use("simrat39/rust-tools.nvim")
		use({
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons", -- optional, for file icon
			},
			config = function()
				require("configs/tree")
			end,
		})
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("configs/trouble")
			end,
		})
		--   use({
		-- "luukvbaal/stabilize.nvim",
		-- config = function()
		--     require("stabilize").setup({ nested = "QuickFixCmdPost,DiagnosticChanged *" })
		-- end,
		--   })
		-- use({ "rcarriga/vim-ultest", requires = { "vim-test/vim-test" }, run = ":UpdateRemotePlugins" })
		use({
			"akinsho/toggleterm.nvim",
			config = require("toggleterm").setup,
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
				vim.g.cpp_compile_command = "g++ -g solution.cpp -o cpp.out"
			end,
		})
		use({
			"narutoxy/dim.lua",
			requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
			config = require("dim").setup,
		})
		use({ "lewis6991/impatient.nvim" })
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
})
