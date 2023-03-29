return {

	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-vim-test",
			"nvim-neotest/neotest-go",
			"olimorris/neotest-rspec",
		},
		keys = {
			{ "<leader>ta", desc = "NeoTest Attach" },
			{ "<leader>tt", desc = "NeoTest Test" },
			{ "<leader>tT", desc = "NeoTest Test File" },
			{ "<leader>tr", desc = "NeoTest Rerun" },
			{ "<leader>ts", desc = "NeoTest Summary" },
			{ "<leader>tl", desc = "NeoTest Logs" },
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-rspec")({
						rspec_cmd = function()
							return vim.tbl_flatten({
								"bundle",
								"exec",
								"rspec",
							})
						end,
					}),

					require("neotest-go"),

					require("neotest-vim-test")({
						ignore_file_types = { "ruby" },
					}),
				},
			})
		end,
	},
}
