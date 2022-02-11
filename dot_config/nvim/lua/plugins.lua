local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	local packer_bootstrap = fn.system({
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
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
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
		use({
			"glepnir/dashboard-nvim",
			config = function()
				vim.g.dashboard_default_executive = "telescope"
			end,
		})
		use("wbthomason/packer.nvim")
		use("tpope/vim-fugitive") -- Git commands in nvim
		use("tpope/vim-rhubarb") -- Fugitive-companion to interact with github
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup({})
			end,
		})
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-ui-select.nvim" } },
			config = function()
				require("tel")
			end,
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
		-- Add git related info in the signs columns and popups
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
				require("ts")
			end,
		})
		-- Additional textobjects for treesitter
		use({
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		}) -- Collection of configurations for built-in LSP client
		-- use({ "ms-jpq/coq_nvim", run = ":COQdeps" })
		use("ms-jpq/coq.artifacts")
		use("ms-jpq/coq.thirdparty")
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use({
			"mfussenegger/nvim-dap",
		})
		use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
		-- use {"tpope/vim-sleuth"}
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		})
		use("mfussenegger/nvim-dap-python")
		use({
			"romgrk/barbar.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
		})
		use({ "nvim-telescope/telescope-dap.nvim" })
		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup({})
			end,
		})
		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})
		use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })
		use("kosayoda/nvim-lightbulb")
		use({
			"petertriho/nvim-scrollbar",
			config = function()
				require("scrollbar").setup()
			end,
		})
		use("sidebar-nvim/sidebar.nvim")
		use("sidebar-nvim/sections-dap")
		use({
			"ThePrimeagen/refactoring.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
		})
		use({ "theHamsta/nvim-dap-virtual-text" })
		use({ "p00f/clangd_extensions.nvim" })
		-- use 'simrat39/rust-tools.nvim'
		use({ "nvim-telescope/telescope-ui-select.nvim" })
		-- use({
		-- 	"kyazdani42/nvim-tree.lua",
		-- 	requires = {
		-- 		"kyazdani42/nvim-web-devicons", -- optional, for file icon
		-- 	},
		-- 	config = function()
		-- 		vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })
		-- 		-- vim.api.nvim_set_keymap("n",'<leader>r',":NvimTreeRefresh<CR>",{noremap = true})
		-- 		-- vim.api.nvim_set_keymap("n",'<leader>n',":NvimTreeFindFile<CR>",{noremap = true})
		-- 		require("nvim-tree").setup({
		-- 			auto_close = true,
		-- 			diagnostics = {
		-- 				enable = true,
		-- 				icons = {
		-- 					hint = "",
		-- 					info = "",
		-- 					warning = "",
		-- 					error = "",
		-- 				},
		-- 			},
		-- 			update_focused_file = {
		-- 				enable = true,
		-- 			},
		-- 			filters = {
		-- 				dotfiles = false,
		-- 			},
		-- 			view = {
		-- 				auto_resize = true,
		-- 			},
		-- 		})
		-- 	end,
		-- })
		use({ "nvim-telescope/telescope-file-browser.nvim" })
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({
					auto_open = true,
					-- auto_close = true,
					auto_fole = true,
					use_diagnostic_signs = true,
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})
		use({
			"luukvbaal/stabilize.nvim",
			config = function()
				require("stabilize").setup()
			end,
		})
		-- use({ "rcarriga/vim-ultest", requires = { "vim-test/vim-test" }, run = ":UpdateRemotePlugins" })
		use({
			"akinsho/toggleterm.nvim",
			config = function()
				require("toggleterm").setup({})
			end,
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
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
})
