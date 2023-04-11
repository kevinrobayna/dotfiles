return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-vim-test",
		"nvim-neotest/neotest-go",
		"olimorris/neotest-rspec",
		"stevearc/overseer.nvim",
	},
	keys = {
		{ "<leader>ta", "<cmd>lua require 'neotest'.run.attach()<cr>", desc = "NeoTest Attach" },
		{ "<leader>tt", "<cmd>lua require 'neotest'.run.run()<cr>", desc = "NeoTest Test" },
		{ "<leader>tT", "<cmd>lua require 'neotest'.run.run(vim.fn.expand('%'))<cr>", desc = "NeoTest Test File" },
		{ "<leader>tr", "<cmd>lua require 'neotest'.run.run_last()<cr>", desc = "NeoTest Rerun" },
		{ "<leader>ts", "<cmd>lua require 'neotest'.summary.toggle()<cr>", desc = "NeoTest Summary" },
		{ "<leader>tl", "<cmd>lua require 'neotest'.output_panel.toggle()<cr>", desc = "NeoTest Logs" },
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
					ignore_file_types = { "ruby", "go" },
				}),
			},
			consumers = {
				overseer = require("neotest.consumers.overseer"),
			},
			diagnostic = {
				enabled = false,
			},
			log_level = 1,
			floating = {
				border = "single",
				max_height = 0.8,
				max_width = 0.9,
			},
			icons = {
				expanded = "",
				child_prefix = "",
				child_indent = "",
				final_child_prefix = "",
				non_collapsible = "",
				collapsed = "",

				passed = "",
				running = "",
				failed = "",
				unknown = "",
				skipped = "",
			},
		})
	end,
}
