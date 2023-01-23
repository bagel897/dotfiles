return {
	"folke/trouble.nvim",
	opts = {
		auto_open = true,
		auto_close = true,
		-- auto_fold = true,
		use_diagnostic_signs = true,
		mode = "document_diagnostics",
	},
	event = "BufReadPost",
	keys = {
		{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
		{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
	},
}
