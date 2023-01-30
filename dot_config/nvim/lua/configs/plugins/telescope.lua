return {
	"nvim-telescope/telescope.nvim",
	opts = {
		defaults = {
			mappings = {
				i = {
					["<c-t>"] = function(...)
						return require("trouble.providers.telescope").open_with_trouble(...)
					end,
					-- ["<C-i>"] = function()
					-- 	Util.telescope("find_files", { no_ignore = true })()
					-- end,
					-- ["<C-h>"] = function()
					-- 	Util.telescope("find_files", { hidden = true })()
					-- end,
					["<C-Down>"] = function(...)
						return require("telescope.actions").cycle_history_next(...)
					end,
					["<C-Up>"] = function(...)
						return require("telescope.actions").cycle_history_prev(...)
					end,
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				overwrite_generic_sorter = true,
				overwrite_file_sorter = true,
				case_mode = "smart_case",
			},
		},
		pickers = {
			find_files = {
				find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
			},
		},
	},
	config = function(opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		-- Enable telescope fzf native
		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
		telescope.load_extension("lsp_handlers")
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"gbrlsnchs/telescope-lsp-handlers.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
	},
	version = false, -- telescope did only one release, so use HEAD for now
	keys = {
		{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
		{ "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Grep)" },
		{ "<leader>fp", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Grep)" },

		{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },

		-- find
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },

		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
		{ "<leader>fF", "<cmd>Telescope find_files cwd=false<cr>", desc = "Find Files (cwd)" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
		-- git
		{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
		{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
		-- search
		{ "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
		{ "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
		{ "<leader>ft", "<cmd>Telescope tags<cr>", desc = "Tags" },
		{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		{ "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
		{ "<leader>fG", "<cmd>Telescope live_grep<cr>", desc = "Grep (cwd)" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
		{ "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
		{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
		{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
		{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
		{ "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Word (root dir)" },
		{ "<leader>sW", "<cmd>Telescope grep_string cwd=false<cr>", desc = "Word (cwd)" },
		{ "<leader>uC", "<cmd>Telescope colorscheme preview=true<cr>", desc = "Colorscheme with preview" },
		{
			"<leader>fl",
			"<cmd> Telescope lsp_document_symbols <cr>",
			desc = "Goto Symbol",
		},
	},
	cmd = "Telescope",
	lazy = true,
}
