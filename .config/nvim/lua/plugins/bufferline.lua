return {
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"moll/vim-bbye",
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("core").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "nvim-tree",
						text = "Nvim-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
	},
}
