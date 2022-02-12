-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.g.coq_settings = { auto_start = "shut-up" }
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
local wk = require("which-key")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
	wk.register({
		l = {
			name = "lsp",
			d = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "type definition" },
			r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
			a = { "<cmd>CodeActionMenu<CR>", "code actions" },
			f = { "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", "format" },
			q = { "<cmd> lua vim.lsp.buf.hover() <CR>", "documentation" },
		},
	}, { prefix = "<leader>" })
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<space>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_command([[augroup Format]])
		vim.api.nvim_command([[autocmd! * <buffer>]])
		vim.api.nvim_command([[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_seq_sync()]])
		vim.api.nvim_command([[augroup END]])
	end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	"rust_analyzer",
	-- "clangd",
	"vimls",
	"bashls",
	-- "sumneko_lua",
	"jsonls",
	"cmake",
	"dockerls",
	"pylsp",
	-- "pyright",
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
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require("clangd_extensions").setup({
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
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
			telemetry = {
				enable = false,
			},
		},
	},
	on_attach = on_attach,
})

-- require("clangd_extensions").setup()

local null_ls = require("null-ls")
local sources = {
	-- null_ls.builtins.formatting.clang_format,
	null_ls.builtins.formatting.stylua,
	-- null_ls.builtins.diagnostics.gitlint,
	-- null_ls.builtins.diagnostics.luacheck,
	-- null_ls.builtins.diagnostics.pylint,
	-- null_ls.builtins.code_actions.refactoring,
}
require("null-ls").setup({
	sources = sources,
	on_attach = on_attach,
})

-- require('rust-tools'--[[ ).setup( ]]{})
-- require('rust-tools.inlay_hints').set_inlay_hints()

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
require("refactoring").setup({})
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})
