return {
	"ThePrimeagen/git-worktree.nvim",
	config = function()
		require("telescope").load_extension("git_worktree")
	end,
	keys = {
		{
			"<leader>wf",
			function()
				require("telescope").extensions.git_worktree.create_git_worktree()
			end,
			desc = "create git worktree",
		},
		{
			"<leader>ws",
			function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end,
			"switch git worktrees",
		},
	},
}
