local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,
	formatting = {
		format = lspkind.cmp_format({ mode = "symbol_text" }),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	-- sorting = {
	-- 	comparators = {
	-- 		cmp.config.compare.offset,
	-- 		cmp.config.compare.exact,
	-- 		cmp.config.compare.score,
	-- 		cmp.config.compare.recently_used,
	-- 		require("clangd_extensions.cmp_scores"),
	-- 		cmp.config.compare.kind,
	-- 		cmp.config.compare.sort_text,
	-- 		cmp.config.compare.length,
	-- 		cmp.config.compare.order,
	-- 		cmp.config.compare.locality,
	-- 		cmp.config
	-- 	},
	-- },
	-- window = {
	-- 	completion = cmp.config.window.bordered(),
	-- },
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4)),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete()),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end),
	}),

	sources = cmp.config.sources({
		{ name = "dap" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "nvim_lsp_signature_help" },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "neorg" },
	}, { { name = "treesitter" } }, {
		{ name = "buffer" },
	}),
})
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "conventionalcommits" },
	}, {
		{ name = "git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.sort_text,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.kind,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "nvim_lsp_document_symbol" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

require("cmp_git").setup()
require("luasnip.loaders.from_snipmate").lazy_load()
