return {

	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
		},
		opts = function()
			return {
				update_focused_file = {
					enable = true,
				},
				renderer = {
					root_folder_modifier = ":t",
					icons = {
						git_placement = "before",
						padding = " ",
						symlink_arrow = " ➛ ",
						glyphs = {
							default = require("core").icons.ui.Text,
							symlink = require("core").icons.ui.FileSymlink,
							bookmark = require("core").icons.ui.BookMark,
							folder = {
								arrow_closed = require("core").icons.ui.TriangleShortArrowRight,
								arrow_open = require("core").icons.ui.TriangleShortArrowDown,
								default = require("core").icons.ui.Folder,
								open = require("core").icons.ui.FolderOpen,
								empty = require("core").icons.ui.EmptyFolder,
								empty_open = require("core").icons.ui.EmptyFolderOpen,
								symlink = require("core").icons.ui.FolderSymlink,
								symlink_open = require("core").icons.ui.FolderOpen,
							},
							git = {
								unstaged = require("core").icons.git.FileUnstaged,
								staged = require("core").icons.git.FileStaged,
								unmerged = require("core").icons.git.FileUnmerged,
								renamed = require("core").icons.git.FileRenamed,
								untracked = require("core").icons.git.FileUntracked,
								deleted = require("core").icons.git.FileDeleted,
								ignored = require("core").icons.git.FileIgnored,
							},
						},
					},
				},

				diagnostics = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
					debounce_delay = 50,
					severity = {
						min = vim.diagnostic.severity.HINT,
						max = vim.diagnostic.severity.ERROR,
					},
					icons = {
						hint = require("core").icons.diagnostics.BoldHint,
						info = require("core").icons.diagnostics.BoldInformation,
						warning = require("core").icons.diagnostics.BoldWarning,
						error = require("core").icons.diagnostics.BoldError,
					},
				},
				view = {
					adaptive_size = true,
					side = "left",
					mappings = {
						list = {
							{ key = { "l", "<CR>", "o" }, cb = require("nvim-tree.config").nvim_tree_callback("edit") },
							{ key = "h", cb = require("nvim-tree.config").nvim_tree_callback("close_node") },
							{ key = "v", cb = require("nvim-tree.config").nvim_tree_callback("vsplit") },
						},
					},
				},
			}
		end,
	},
}
