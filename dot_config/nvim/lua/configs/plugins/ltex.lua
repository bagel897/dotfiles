return {
	"vigoux/ltex-ls.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	ft = { "latex", "tex", "bib", "markdown" },
	config = function()
		local capabilities = require("configs.capabilities").default_capabilities()
		capabilities.window.workDoneProgress = false
		local on_attach = require("configs.on_attach_no_ih")
		require("ltex-ls").setup({
			on_attach = on_attach,
			capabilities = capabilities,
			use_spellfile = true,
			settings = {
				ltex = {
					completionEnabled = true,
					enabled = { "latex", "tex", "bib", "markdown" },
					language = "en-US",
					diagnosticSeverity = "information",
					sentenceCacheSize = 2000,
					additionalRules = {
						enablePickyRules = true,
						motherTongue = "en-US",
					},
					dictionary = (function()
						-- For dictionary, search for files in the runtime to have
						-- and include them as externals the format for them is
						-- dict/{LANG}.txt
						--
						-- Also add dict/default.txt to all of them
						local files = {}
						for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
							local lang = vim.fn.fnamemodify(file, ":t:r")
							local fullpath = vim.fs.normalize(file, ":p")
							files[lang] = { ":" .. fullpath }
						end

						if files.default then
							for lang, _ in pairs(files) do
								if lang ~= "default" then
									vim.list_extend(files[lang], files.default)
								end
							end
							files.default = nil
						end
						return files
					end)(),
				},
			},
		})
	end,
}
