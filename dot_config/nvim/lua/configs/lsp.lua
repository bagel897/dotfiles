-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.g.coq_settings = { auto_start = "shut-up" }
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
vim.g.markdown_fenced_languages = {
	"ts=typescript",
}
local servers = {
	-- "texlab",
	"ltex",
	"rust_analyzer",
	"yamlls",
	-- "prosemd_lsp",
	-- "ccls",
	-- "clangd",
	"vimls",
	"bashls",
	-- "sumneko_lua",
	"jsonls",
	"cmake",
	"dockerls",
	-- "pylsp",
	-- "pyright",
	"gdscript",
}
require("lspconfig").denols.setup({
	init_options = {
		lint = true,
	},
	capabilities=capabilities
})
-- local coq = require("coq")
for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		capabilities = capabilities,
		-- flags = {
		-- 	debounce_text_changes = 150,
		-- },
	})
end
require("lspconfig").pylsp.setup({
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = { enabled = true, maxLineLength = 88 },
				pydocstyle = { enabled = true },
				rope_autoimport = { enabled = true },
				-- pylint = { enabled = true, args = {"--disable C0301"}},
			},
		},
	},
	capabilities = capabilities,
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
})
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
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
	},
})
require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
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
		},
	},
	capabilities = capabilities,
})

local null_ls = require("null-ls")
local sources = {
	-- null_ls.builtins.formatting.clang_format,
	null_ls.builtins.formatting.stylua,
	-- null_ls.builtins.diagnostics.gitlint,
	-- null_ls.builtins.diagnostics.luacheck,
	-- null_ls.builtins.diagnostics.pylint,
	-- null_ls.builtins.code_actions.refactoring,
	-- null_ls.builtins.formatting.black,
	-- Black can be finnicky on the lsp side so I use Null to back it up
}
require("null-ls").setup({
	sources = sources,
})

-- require('rust-tools'--[[ ).setup( ]]{})
-- require('rust-tools.inlay_hints').set_inlay_hints()

require("refactoring").setup({})
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})
