local is_git = function()
	local git_dir = vim.fn.finddir(".git", vim.api.nvim_buf_get_name(0) .. ";")
	return git_dir ~= ""
end
local on_attach = function(client, bufnr, ih)
	-- your usual configuration — options, keymaps, etc

	require("lsp-inlayhints").on_attach(client, bufnr)
	--
	-- require("lsp-format").on_attach(client, bufnr)
	-- if client.server_capabilities.documentRangeFormattingProvider == true and is_git() then
	-- 	local lsp_format_modifications = require("lsp-format-modifications")
	-- 	lsp_format_modifications.attach(client, bufnr, { format_on_save = true })
	-- else
	-- 	require("lsp-format").on_attach(client, bufnr)
	-- end
end
return on_attach
