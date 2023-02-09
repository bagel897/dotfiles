local is_git = function()
	local result = io.popen("git rev-parse --is-inside-work-tree").close
	return result.exitcode ~= 0
end
local on_attach = function(client, bufnr, ih)
	-- your usual configuration — options, keymaps, etc

	if ih then
		require("inlay-hints").on_attach(client, bufnr)
	end
	require("lsp-format").on_attach(client, bufnr)

	-- if client.server_capabilities.documentRangeFormattingProvider then
	-- 	local lsp_format_modifications = require("lsp-format-modifications")
	-- 	lsp_format_modifications.attach(client, bufnr, { format_on_save = true })
	-- else
	-- 	require("lsp-format").on_attach(client, bufnr)
	-- end
end
return on_attach
