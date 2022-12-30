return {
	"p00f/cphelper.nvim",
	config = function()
		vim.g.cphlang = "python"
		vim.g.cpp_compile_command = "g++ -g solution.cpp -o solution"
	end,
	enabled = false,
}
