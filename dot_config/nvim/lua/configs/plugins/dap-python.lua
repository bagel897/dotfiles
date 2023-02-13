return {
    "mfussenegger/nvim-dap-python",
    config = function()
	    require("dap-python").setup("python")
	    require('dap-python').test_runner = 'pytest'
    end,
    keys = {
        {
            "<leader>dds",
            function()
	            require("dap-python").debug_selection()
            end,
            desc = "debug selection python",
        },
    },
    ft = "python",
}
