local cfg = function()
	-- Mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	-- vim.g.coq_settings = { auto_start = "shut-up" }
	--
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local on_attach = require("configs.on_attach")
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
		"tsserver",
	}
	-- require("lspconfig").denols.setup({
	-- 	init_options = {
	-- 		lint = true,
	-- 	},
	-- 	capabilities = capabilities,
	-- 	on_attach = on_attach,
	-- })
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
end
return {
	"neovim/nvim-lspconfig",
	config = cfg,
}
