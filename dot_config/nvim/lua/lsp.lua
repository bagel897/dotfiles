-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.g.coq_settings = { auto_start = "shut-up" }
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
local wk = require("which-key")
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
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
	"clangd",
	"vimls",
	"bashls",
	"sumneko_lua",
	"jsonls",
	"cmake",
	"dockerls",
	"pylsp",
	-- "pyright",
}
local coq = require("coq")
for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup(coq.lsp_ensure_capabilities({
		on_attach = on_attach,
		flags = {
			-- This will be the default in neovim 0.7+
			debounce_text_changes = 150,
		},
	}))
end
require("lspconfig").sumneko_lua.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}))
local null_ls = require("null-ls")
local sources = {
	null_ls.builtins.formatting.black,
	-- null_ls.builtins.formatting.clang_format,
	null_ls.builtins.formatting.stylua,
	-- null_ls.builtins.diagnostics.flake8,
	null_ls.builtins.diagnostics.gitlint,
	-- null_ls.builtins.diagnostics.luacheck,
	-- null_ls.builtins.diagnostics.pylint,
	null_ls.builtins.code_actions.refactoring,
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
