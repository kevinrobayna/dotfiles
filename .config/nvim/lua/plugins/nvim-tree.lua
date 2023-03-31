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
						glyphs = {
							default = "",
							symlink = "",
							folder = {
								arrow_open = "",
								arrow_closed = "",
								default = "",
								open = "",
								empty = "",
								empty_open = "",
								symlink = "",
								symlink_open = "",
							},
							git = {
								unstaged = "",
								staged = "S",
								unmerged = "",
								renamed = "➜",
								untracked = "U",
								deleted = "",
								ignored = "◌",
							},
						},
					},
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					icons = {
						hint = require("core").icons.diagnostics.Hint,
						info = require("core").icons.diagnostics.Info,
						warning = require("core").icons.diagnostics.Warn,
						error = require("core").icons.diagnostics.Error,
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
