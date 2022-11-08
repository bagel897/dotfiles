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
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
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
			"ThePrimeagen/refactoring.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
			config = function()
				require("refactoring").setup({})
				require("telescope").load_extension("refactoring")

				-- remap to open the Telescope refactoring menu in visual mode
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
			"stevearc/dressing.nvim",
			config = function()
				require("dressing").setup({})
			end,
		})
		-- use({
		-- 	"Olical/conjure",
		-- 	"PaterJason/cmp-conjure",
		-- 	config = function()
		-- 		vim.g.conjure.mapping.prefix = ",c"
		-- 	end,
		-- 	disable = true,
		-- })
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
			"nvim-neorg/neorg",
			config = function()
				require("neorg").setup({
					load = {
						["core.defaults"] = {},
						["core.norg.concealer"] = {},
						["core.integrations.nvim-cmp"] = {},
					},
				})
			end,
			disable = true,
			requires = "nvim-lua/plenary.nvim",
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
		use({ "wbthomason/packer.nvim" })
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
			config = function()
				require("tokyonight").setup({ style = "storm" })
			end,
			disable = true,
		})

		use({
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
				require("catppuccin").setup({
					integration = {
						barbar = true,
						dashboard = true,
						gitsigns = true,
						lightspeed = true,
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
						fidget = true,
						indent_blankline = {
							enabled = true,
							colored_indent_levels = false,
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
		})
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("lualine").setup({
					options = {
						globalstatus = true,
						theme = "catppuccin",
					},
					extensions = { "nvim-tree", "quickfix", "fugitive", "toggleterm", "symbols-outline" },
					sections = {
						lualine_c = { { "filename", path = 1 } },
						lualine_x = {
							{
								require("noice").api.status.message.get_hl,
								cond = require("noice").api.status.message.has,
							},
							{
								require("noice").api.status.command.get,
								cond = require("noice").api.status.command.has,
								color = { fg = "#ff9e64" },
							},
							{
								require("noice").api.status.mode.get,
								cond = require("noice").api.status.mode.has,
								color = { fg = "#ff9e64" },
							},
							{
								require("noice").api.status.search.get,
								cond = require("noice").api.status.search.has,
								color = { fg = "#ff9e64" },
							},
						},
					},
				})
			end,
			after = "noice.nvim",
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
		use({ "p00f/nvim-ts-rainbow" })
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
			"nvim-treesitter/nvim-treesitter-textobjects",
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

			"petertriho/cmp-git",
			config = function()
				require("cmp_git").setup()
			end,
		})
		use({
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load({
					paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets/" },
				})
			end,
			after = { "nvim-cmp" },
		})

		use({
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/nvim-cmp",
			"rcarriga/cmp-dap",
			"davidsierradz/cmp-conventionalcommits",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
			"ray-x/cmp-treesitter",
			requires = { "nvim-lua/plenary.nvim", "L3MON4D3/LuaSnip" },
			after = { "nvim-lspconfig", "nvim-autopairs" },
			config = function()
				require("configs/cmp.lua")
			end,
		})
		use({
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup({})
			end,
		})
		use({
			"jayp0521/mason-nvim-dap.nvim",
			after = {
				"mason.nvim",
			},
			requires = {
				"mfussenegger/nvim-dap",
				"williamboman/mason.nvim",
			},
			config = function()
				require("mason-nvim-dap").setup({ automatic_installation = true, automatic_setup = true })
			end,
		})
		use({
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			after = {
				"null-ls.nvim",
				"mason.nvim",
				"lspconfig.nvim",
			},
			config = function()
				require("mason-lspconfig").setup({ automatic_installation = true })
				require("mason-tool-installer").setup({
					auto_update = true,
					ensure_installed = {
						"flake8",
					},
				})
				require("mason-lspconfig").setup({
					automatic_installation = true,
				})
			end,
			run = function()
				vim.cmd("PylspInstall pyls-isort pylsp-rope pylsp-mypy python-lsp-black")

				vim.cmd(":MasonToolsUpdate <CR>")
			end,
		})
		use({
			"glepnir/lspsaga.nvim",
			branch = "main",
			config = function()
				local saga = require("lspsaga")

				saga.init_lsp_saga({
					symbol_in_winbar = { enable = true },
					-- your configuration
				})
			end,
		})
		use({
			"p00f/clangd_extensions.nvim",
			config = function()
				require("clangd_extensions").setup({
					server = {
						cmd = {
							"clangd",
							"--background-index",
							"-j=12",
							"--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
							"--clang-tidy",
							"--all-scopes-completion",
							"--cross-file-rename",
							"--completion-style=detailed",
							"--header-insertion-decorators",
							"--header-insertion=iwyu",
							"--pch-storage=memory",
						},
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
						on_attach = require("lsp-format").on_attach,
					},
				})
			end,
		})
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				local null_ls = require("null-ls")
				local sources = {
					-- null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.rstcheck,
					null_ls.builtins.formatting.prettier,
					-- null_ls.builtins.formatting.joker,
					-- null_ls.builtins.diagnostics.clj_kondo,
					null_ls.builtins.formatting.cljstyle,
					-- null_ls.builtins.code_actions.gitsigns,
					-- null_ls.builtins.diagnostics.gitlint,
					-- null_ls.builtins.diagnostics.luacheck,
					-- null_ls.builtins.diagnostics.pylint,
					-- null_ls.builtins.code_actions.refactoring,
					-- null_ls.builtins.formatting.black,
					-- Black can be finnicky on the lsp side so I use Null to back it up
				}
				require("null-ls").setup({
					sources = sources,
					on_attach = require("lsp-format").on_attach,
				})
			end,
		})
		use({
			"neovim/nvim-lspconfig",
			config = function()
				-- Mappings.
				-- See `:help vim.diagnostic.*` for documentation on any of the below functions
				-- vim.g.coq_settings = { auto_start = "shut-up" }
				--
				local capabilities = require("cmp_nvim_lsp").default_capabilities()
				local on_attach = function(client, bufnr)
					require("lsp-format").on_attach(client)
				end
				-- Use a loop to conveniently call 'setup' on multiple servers and
				-- map buffer local keybindings when the language server attaches
				vim.g.markdown_fenced_languages = {
					"ts=typescript",
				}
				local servers = {
					"taplo",
					"clojure_lsp",
					-- "texlab",
					"ltex",
					"rust_analyzer",
					-- "prosemd_lsp",
					"vimls",
					"bashls",
					"jsonls",
					"cmake",
					"esbonio",
					"dockerls",
					-- "pyright",
					-- "jedi_language_server",
					"gdscript",
				}
				require("lspconfig").denols.setup({
					init_options = {
						lint = true,
					},
					capabilities = capabilities,
					on_attach = on_attach,
				})
				-- local coq = require("coq")
				for _, lsp in pairs(servers) do
					require("lspconfig")[lsp].setup({
						capabilities = capabilities,
						-- flags = {
						-- 	debounce_text_changes = 150,
						-- },
						on_attach = on_attach,
					})
				end
				-- require("lspconfig").sourcery.setup({
				-- 	capabilities = capabilities,
				-- 	on_attach = on_attach,
				-- 	init_options = {
				-- 		editor_version = "vim",
				-- 		extension_version = "vim.lsp",
				--
				-- 	},
				-- })
				require("lspconfig").pylsp.setup({
					settings = {
						pylsp = {
							plugins = {
								pycodestyle = { enabled = true, maxLineLength = 88 },
								-- pydocstyle = { enabled = true },
								rope_autoimport = { enabled = true, memory = false },
								pylsp_mypy = {
									enabled = true,
									live_mode = false,
									dmypy = true,
								},
								-- pylint = { enabled = true, args = {"--disable C0301"}},
							},
						},
					},
					capabilities = capabilities,
					on_attach = on_attach,
				})
				require("lspconfig").texlab.setup({
					settings = {
						texlab = {
							auxDirectory = ".",
							bibtexFormatter = "texlab",
							build = {
								args = { "--keep-logs", "--keep-intermediates", "-synctex", "$f" },
								executable = "tectonic",
								forwardSearchAfter = false,
								onSave = true,
							},
							chktex = {
								onEdit = false,
								onOpenAndSave = true,
							},
							diagnosticsDelay = 300,
							formatterLineLength = 80,
							forwardSearch = {
								args = {},
							},
							latexFormatter = "latexindent",
							latexindent = {
								modifyLineBreaks = true,
							},
						},
					},
					capabilities = capabilities,
					on_attach = on_attach,
				})
				require("lspconfig").sumneko_lua.setup({
					settings = {
						completion_style = {
							call_snipped = "Replace",
						},
						Lua = {
							hint = {
								enable = true,
							},
							runtime = {
								-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
								-- Setup your lua path
							},
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = { "vim" },
							},
							workspace = {
								-- Make the server aware of Neovim runtime files
								library = vim.api.nvim_get_runtime_file("", true),
							},
							-- Do not send telemetry data containing a randomized but unique identifier
							telemetry = {
								enable = false,
							},
						},
					},
					capabilities = capabilities,
					on_attach = on_attach,
				})

				vim.diagnostic.config({
					virtual_text = false,
					signs = true,
					underline = true,
					update_in_insert = false,
					severity_sort = true,
				})
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
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end,
		})
		use({
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			config = function()
				require("lsp_lines").setup()
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
			"mrbjarksen/neo-tree-diagnostics.nvim",
			requires = "nvim-neo-tree/neo-tree.nvim",
			module = "neo-tree.sources.diagnostics", -- if wanting to lazyload
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
		-- use({
		-- 	"narutoxy/dim.lua",
		-- 	requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
		-- 	config = function()
		-- 		require("dim").setup({})
		-- 	end,
		-- })
		use({ "nvim-lua/popup.nvim", requires = { "nvim-lua/plenary.nvim" } })
		use({
			"ThePrimeagen/git-worktree.nvim",
			config = function()
				require("telescope").load_extension("git_worktree")
			end,
		})
		use({
			"RubixDev/mason-update-all",
			config = function()
				require("mason-update-all").setup()
			end,
			run = ":MasonUpdateAll",
		})
		use({
			"jayp0521/mason-null-ls.nvim",
			after = {
				"null-ls.nvim",
				"mason.nvim",
			},
			config = function()
				require("mason-null-ls").setup({
					automatic_installation = true,
					automatic_setup = true,
				})
			end,
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
				local cfg = require("yaml-companion").setup({
					{
						-- Built in file matchers
						builtin_matchers = {
							-- Detects Kubernetes files based on content
							kubernetes = { enabled = true },
						},

						-- Additional schemas available in Telescope picker
						schemas = {
							result = {
								--{
								--  name = "Kubernetes 1.22.4",
								--  uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
								--},
							},
						},

						-- Pass any additional options that will be merged in the final LSP config
						lspconfig = {
							flags = {
								debounce_text_changes = 150,
							},
							settings = {
								redhat = { telemetry = { enabled = false } },
								yaml = {
									validate = true,
									format = { enable = true },
									hover = true,
									schemaStore = {
										enable = true,
										url = "https://www.schemastore.org/api/json/catalog.json",
									},
									schemaDownload = { enable = true },
									schemas = {},
									trace = { server = "debug" },
								},
							},
							on_attach = require("lsp-format").on_attach,
						},
					},
				})
				require("lspconfig")["yamlls"].setup(cfg)
				require("telescope").load_extension("yaml_schema")
			end,
		})
		use({
			"nvim-neotest/neotest",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"nvim-neotest/neotest-python",
				"haydenmeade/neotest-jest",
			},
			config = function()
				require("neotest").setup({
					adapters = {
						require("neotest-jest")({
							jestCommand = "npm test --",
							jestConfigFile = "custom.jest.config.ts",
							env = { CI = true },
							cwd = function(path)
								return vim.fn.getcwd()
							end,
						}),

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
			"folke/noice.nvim",
			requires = {
				-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
				"MunifTanjim/nui.nvim",
				-- OPTIONAL:
				--   `nvim-notify` is only needed, if you want to use the notification view.
				--   If not available, we use `mini` as the fallback
				"rcarriga/nvim-notify",
			},
			after = { "nvim-cmp" },
			config = function()
				require("noice").setup({
					lsp = {
						override = {
							-- override the default lsp markdown formatter with Noice
							["vim.lsp.util.convert_input_to_markdown_lines"] = true,
							-- override the lsp markdown formatter with Noice
							["vim.lsp.util.stylize_markdown"] = true,
							-- override cmp documentation with Noice (needs the other options to work)
							["cmp.entry.get_documentation"] = true,
						},
					},
				})
			end,
		})
		use({
			"s1n7ax/nvim-window-picker",
			tag = "v1.*",
			config = function()
				require("window-picker").setup()
			end,
		})
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
})
