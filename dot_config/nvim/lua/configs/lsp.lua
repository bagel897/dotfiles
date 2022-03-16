-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.g.coq_settings = { auto_start = "shut-up" }
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
local wk = require("which-key")
-- local coq = require("coq")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
	wk.register({
		l = {
			name = "lsp",
			d = { vim.lsp.buf.type_definition, "type definition" },
			r = { vim.lsp.buf.rename, "rename" },
			a = { "<cmd>CodeActionMenu<CR>", "code actions" },
			f = { vim.lsp.buf.formatting, "format" },
			q = { vim.lsp.buf.hover, "documentation" },
			i = { vim.lsp.buf.implementation, "implementation" },
			c = { vim.lsp.buf.incoming_calls, "incoming calls" },
			o = { vim.lsp.buf.outgoing_calls, "outgoing calls" },
		},
	}, { prefix = "<leader>" })
	-- vim.keymap.set("v", "<leader>la", vim.lsp.buf.range_code_action)

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	"texlab",
	"ltex",
	"rust_analyzer",
	-- "ccls",
	-- "clangd",
	"vimls",
	"bashls",
	-- "sumneko_lua",
	"jsonls",
	"cmake",
	"dockerls",
	-- "pylsp",
	"pyright",
}

-- local coq = require("coq")
for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		-- flags = {
		-- 	debounce_text_changes = 150,
		-- },
	})
end
require("lspconfig").pylsp.setup({
	on_attach = on_attach,
	settings = {
		pylsp = {
			plugins = { pydocstyle = { enabled = true }, pylint = { enabled = false }, flake8 = { enabled = true } },
		},
	},
	capabilities = capabilities,
})
require("lspconfig").texlab.setup({
	on_attach == on_attach,
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
		on_attach = on_attach,
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
	on_attach = on_attach,
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
	on_attach = on_attach,
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
