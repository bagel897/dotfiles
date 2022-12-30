return {
	"neomake/neomake",
	config = function()
		vim.cmd([[call neomake#configure#automake('w')]])
	end,
	enabled = false,
}
