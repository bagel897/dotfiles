vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'
  use 'onsails/lspkind-nvim'
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'mjlbach/onedark.nvim' -- Theme inspired by Automatic
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
    -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'ms-jpq/coq_nvim'
  use 'ms-jpq/coq.artifacts'
  use 'ms-jpq/coq.thirdparty'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use {'tpope/vim-sleuth'}
  use {'jiangmiao/auto-pairs'}
  use 'mfussenegger/nvim-dap-python'
  use {
  'romgrk/barbar.nvim',
  requires = {'kyazdani42/nvim-web-devicons'}
  }
  use {"nvim-telescope/telescope-dap.nvim"}
  use {"folke/which-key.nvim"}
  use 'mfussenegger/nvim-lint'
  use{ 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu',}
  use 'kosayoda/nvim-lightbulb'
  use("petertriho/nvim-scrollbar")
  use("sidebar-nvim/sidebar.nvim")
  -- use{"ms-jpq/chadtree", run = 'python3 -m chadtree deps'}
  use("sidebar-nvim/sections-dap")
  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
    }
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {
      auto_close=true,
      diagnostics= {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        }
      },
      update_focused_file = {
        enable = true,
      },
      filters = {
        dotfiles = false,
      },
      view = {
        auto_resize = true,
      }
    } end
  }
  end,
})

