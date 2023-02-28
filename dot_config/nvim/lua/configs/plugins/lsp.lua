local cfg = function()
	-- Mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	-- vim.g.coq_settings = { auto_start = "shut-up" }
	--
	local capabilities = require("configs.capabilities").default_capabilities()
	local on_attach_no_ih = require("configs.on_attach_no_ih")
	local on_attach_ih = require("configs.on_attach_ih")
	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	vim.g.markdown_fenced_languages = {
		"ts=typescript",
	}

	require("mason-lspconfig").setup({
		ensure_installed = { "jdtls" },
		automatic_installation = true,
	})
	local default = {
		capabilities = capabilities,
		-- flags = {
		-- 	debounce_text_changes = 150,
		-- },
		on_attach = on_attach_no_ih,
	}
	local servers = {
		"taplo",
		"clojure_lsp",
		-- "prosemd_lsp",
		"vimls",
		"bashls",
		"ruff_lsp",
		"cmake",
		"esbonio",
		"gradle_ls",

		"marksman",
		"dockerls",
		-- "pyright",
		-- "jedi_language_server",
		"gdscript",
		"groovyls",
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
		require("lspconfig")[lsp].setup(default)
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
						report_progress = true,
					},
					pylint = { enabled = true, args = { "--disable C0301" } },
				},
			},
		},
		capabilities = capabilities,
		on_attach = on_attach_no_ih,
	})

	require("lspconfig").lua_ls.setup({
		settings = {
			completion = {
				callSnippet = "Replace",
			},
			Lua = {
				hint = {
					enable = true,
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
		capabilities = capabilities,
		on_attach = on_attach_ih,
	})
	require("lspconfig").jsonls.setup({
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
				format = { enable = true },
			},
		},
	})
end
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
		"mason-lspconfig.nvim",
		"lsp-inlayhints.nvim",
		{
			"b0o/SchemaStore.nvim",
			version = false, -- last release is way too old
		},
		{
			"yioneko/nvim-type-fmt",
			event = "BufReadPre",
		},
	},
	config = cfg,
	event = "BufRead",
}
