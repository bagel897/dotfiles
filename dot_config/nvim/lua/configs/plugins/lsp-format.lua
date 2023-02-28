return {
	"lukas-reineke/lsp-format.nvim",
	config = function()
		require("lsp-format").setup({})
		vim.api.nvim_create_augroup("LspAttach_format", {})
		vim.api.nvim_create_autocmd("LspAttach", {
			group = "LspAttach_format",
			callback = function(args)
				if not (args.data and args.data.client_id) then
					return
				end

				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				require("lsp-format").on_attach(client, bufnr)
			end,
		})
	end,
	event = { "BufReadPre", "BufNewFile" },
}
