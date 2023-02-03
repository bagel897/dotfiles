M = {}
M.default_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.textDocument.completion = cmp_capabilities.textDocument.completion
	return capabilities
end
return M
