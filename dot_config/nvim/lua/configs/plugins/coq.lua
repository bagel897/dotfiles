return {

	"ms-jpq/coq_nvim",
	dependencies = {
		"ms-jpq/coq.artifacts",
		"ms-jpq/coq.thirdparty",
	},
	config = function()
		vim.g.coq_settings = { auto_start = "shut-up", xdg = true }
		require("coq_3p")({

			{ src = "nvimlua", short_name = "nLUA", conf_only = true },
			{ src = "dap" },
		})
	end,
	run = ":COQDeps",
	enabled = false,
}
