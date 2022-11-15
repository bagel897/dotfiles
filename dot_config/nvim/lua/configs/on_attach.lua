local on_attach = function(client, bufnr)
	-- your usual configuration — options, keymaps, etc
	-- ...

	if client.server_capabilities.documentRangeFormattingProvider then
		local lsp_format_modifications = require("lsp-format-modifications")
		lsp_format_modifications.attach(client, bufnr, { format_on_save = true })
	else
		require("lsp-format").on_attach(client, bufnr)
	end
end
return on_attach
