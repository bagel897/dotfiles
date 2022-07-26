-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.g.coq_settings = { auto_start = "shut-up" }
require("mason-lspconfig").setup({
	automatic_installation = true,
})
--
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
	require("lsp_signature").on_attach()
	navic.attach(client, bufnr)
	require("lsp-format").on_attach(client)
end
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
vim.g.markdown_fenced_languages = {
	"ts=typescript",
}
local servers = {
	-- "texlab",
	"ltex",
	"rust_analyzer",
	-- "prosemd_lsp",
	-- "ccls",
	-- "clangd",
	"vimls",
	"bashls",
	-- "sumneko_lua",
	"jsonls",
	"cmake",
	"esbonio",
	"dockerls",
	-- "pylsp",
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
local lspconfig = require("lspconfig")
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
require("clangd_extensions").setup({
	server = {
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--all-scopes-completion",
			"--cross-file-rename",
			"--completion-style=detailed",
			"--header-insertion-decorators",
			"--header-insertion=iwyu",
			"--pch-storage=memory",
		},
		capabilities = capabilities,
		on_attach = on_attach,
	},
})
require("lspconfig").sumneko_lua.setup({
	settings = {
		completion_style = {
			call_snipped = "Replace",
		},
		Lua = {
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

local null_ls = require("null-ls")
local sources = {
	-- null_ls.builtins.formatting.clang_format,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.diagnostics.rstcheck,
	null_ls.builtins.formatting.prettier
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
	on_attach = on_attach,
})
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
			on_attach = on_attach,
		},
	},
})
require("lspconfig")["yamlls"].setup(cfg)
-- require('rust-tools'--[[ ).setup( ]]{})
-- require('rust-tools.inlay_hints').set_inlay_hints()

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
