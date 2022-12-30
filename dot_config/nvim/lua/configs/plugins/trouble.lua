local cfg = function()
	local trouble = require("trouble")
	trouble.setup({
		auto_open = true,
		auto_close = true,
		-- auto_fold = true,
		use_diagnostic_signs = true,
		mode = "document_diagnostics",
	})
end
return {
	"folke/trouble.nvim",
	config = cfg,
	enabled = true,
}
