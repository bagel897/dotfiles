return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        "mason.nvim",
    },
    config = function()
	    require("mason-tool-installer").setup({
	        ensure_installed = { "latexindent" },
	        auto_update = true,
	    })
    end,
    event = "BufReadPost",
}
