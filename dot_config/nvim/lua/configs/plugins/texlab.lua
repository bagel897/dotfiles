return {
	"f3fora/nvim-texlabconfig",
	build = "go build -o ~/.local/bin",
	ft = { "tex", "bib" },
	config = function()
		require("lspconfig").texlab.setup({
			settings = {
				texlab = {
					auxDirectory = ".",
					bibtexFormatter = "texlab",
					build = {
						args = { "-X", "compile", "%f", "--keep-logs", "--keep-intermediates", "--synctex" },
						executable = "tectonic",
						forwardSearchAfter = false,
						onSave = true,
					},
					chktex = {
						onEdit = true,
						onOpenAndSave = true,
					},
					diagnosticsDelay = 300,
					formatterLineLength = 80,
					forwardSearch = {
						executable = "evince-synctex",
						args = { "-f", "%l", "%p", '"nvim-texlabconfig -file %f -line %l"' },
					},
					latexFormatter = "latexindent",
					latexindent = {
						modifyLineBreaks = true,
					},
				},
			},
			capabilities = require("configs.capabilities").default_capabilities(),
			on_attach = require("configs.on_attach_no_ih"),
		})
	end,
}
