vim.cmd(
  [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]
)
return require("packer").startup(
  {
    function(use)
      use {
        "glepnir/dashboard-nvim",
        config = function()
          vim.g.dashboard_default_executive = "telescope"
        end
      }
      use "wbthomason/packer.nvim"
      use "tpope/vim-fugitive" -- Git commands in nvim
      use "tpope/vim-rhubarb" -- Fugitive-companion to interact with github
      use {
        "numToStr/Comment.nvim",
        config = function()
          require("Comment").setup {}
        end
      }
      -- "gc" to comment visual regions/lines
      use "ludovicchabant/vim-gutentags" -- Automatic tags management
      use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/plenary.nvim"}, {"nvim-telescope/telescope-ui-select.nvim"}},
        config = function()
          require("tel")
        end
      }
      use "mjlbach/onedark.nvim" -- Theme inspired by Automatic
      use {
        "nvim-lualine/lualine.nvim",
        config = function()
          require("lualine").setup {
            options = {
              icons_enabled = true,
              theme = "onedark",
              component_separators = "|",
              section_separators = ""
            },
            extensions = {"nvim-tree", "fzf", "quickfix", "fugitive"}
          }
        end
      }
      -- -- Add indentation guides even on blank lines
      -- use "lukas-reineke/indent-blankline.nvim"
      -- Add git related info in the signs columns and popups
      use {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = function()
          require("gitsigns").setup {
            signs = {
              add = {text = "+"},
              change = {text = "~"},
              delete = {text = "_"},
              topdelete = {text = "‾"},
              changedelete = {text = "~"}
            }
          }
        end
      }
      -- Highlight, edit, and navigate code using a fast incremental parsing library
      use {
        "nvim-treesitter/nvim-treesitter",
        require = {"nvim-treesitter/nvim-treesitter-textobjects"},
        run = ":TSUpdate",
        config = function()
          require("ts")
        end
      }
      -- Additional textobjects for treesitter
      use "neovim/nvim-lspconfig" -- Collection of configurations for built-in LSP client
      use "ms-jpq/coq_nvim"
      use "ms-jpq/coq.artifacts"
      use "ms-jpq/coq.thirdparty"
      use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
      use {
        "rcarriga/nvim-dap-ui",
        requires = {"mfussenegger/nvim-dap"},
        config = function()
          require("dap_setup")
        end
      }
      -- use {"tpope/vim-sleuth"}
      use {
        "windwp/nvim-autopairs",
        config = function()
          require("nvim-autopairs").setup {}
        end
      }
      use "mfussenegger/nvim-dap-python"
      use {
        "romgrk/barbar.nvim",
        requires = {"kyazdani42/nvim-web-devicons"}
      }
      use {"nvim-telescope/telescope-dap.nvim"}
      use {
        "folke/which-key.nvim",
        config = function()
          require("which-key").setup {}
        end
      }
      -- use "mfussenegger/nvim-lint"
      -- use {
      --   "mhartington/formatter.nvim",
      --   config = function()
      --     require("formatting")
      --   end
      -- }
      -- use({
      --   "jose-elias-alvarez/null-ls.nvim",
      --   config = function()
      --       require("null-ls").setup({
      --         sources = {
      --
      --       require("null-ls").builtins.formatting.stylua,
      --       require("null-ls").builtins.diagnostics.eslint,
      --       require("null-ls").builtins.completion.spell,
      --   },})
      --   end,
      --   requires = { "nvim-lua/plenary.nvim" },
      -- })
      -- use {'jose-elias-alvarez/null-ls.nvim', config = function() require("formatting")end}
      use {"weilbith/nvim-code-action-menu", cmd = "CodeActionMenu"}
      use "kosayoda/nvim-lightbulb"
      use {
        "petertriho/nvim-scrollbar",
        config = function()
          require("scrollbar").setup()
        end
      }
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
      use {"theHamsta/nvim-dap-virtual-text"}
      -- use 'simrat39/rust-tools.nvim'
      use {"nvim-telescope/telescope-ui-select.nvim"}
      use {
        "kyazdani42/nvim-tree.lua",
        requires = {
          "kyazdani42/nvim-web-devicons" -- optional, for file icon
        },
        config = function()
          require "nvim-tree".setup {
            auto_close = true,
            diagnostics = {
              enable = true,
              icons = {
                hint = "",
                info = "",
                warning = "",
                error = ""
              }
            },
            update_focused_file = {
              enable = true
            },
            filters = {
              dotfiles = false
            },
            view = {
              auto_resize = true
            }
          }
        end
      }
      use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
          require("trouble").setup {
            auto_open = true,
            auto_close = true,
            auto_fole = true,
            use_diagnostic_signs = true
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
          }
        end
      }
    end
  }
)