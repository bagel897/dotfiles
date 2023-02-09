return {
	"numToStr/Comment.nvim",
	opts = {
		pre_hook = function()
			require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
		end,
	},
	event = "BufReadPost"
}
