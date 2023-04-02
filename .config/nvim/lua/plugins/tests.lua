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
	},
	{
		"mfussenegger/nvim-dap", -- Debug Adapter Protocol for Neovim
		dependencies = {
			"theHamsta/nvim-dap-virtual-text", -- help to find variable definitions in debug mode
			"rcarriga/nvim-dap-ui", -- Nice UI for nvim-dap

			"suketa/nvim-dap-ruby",
			"leoluz/nvim-dap-go",
		},
		keys = {
			{ "<leader>db", "<cmd>lua require 'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
			{ "<leader>dc", "<cmd>lua require 'dap'.continue()<cr>", desc = "Continue" },
			{ "<leader>do", "<cmd>lua require 'dap'.step_over()<cr>", desc = "Step Over" },
			{ "<leader>di", "<cmd>lua require 'dap'.step_into()<cr>", desc = "Step Into" },
			{ "<leader>dw", "<cmd>lua require 'dap.ui.widgets'.hover()<cr>", desc = "Widgets" },
			{ "<leader>dr", "<cmd>lua require 'dap'.repl.toggle()<cr>", desc = "REPL" },
			{ "<leader>du", "<cmd>lua require 'dapui'.toggle({})<cr>", desc = "Dap UI" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			---Show custom virtual text when debugging
			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "DebugBreakpoint",
				linehl = "",
				numhl = "DebugBreakpoint",
			})
			vim.fn.sign_define("DapStopped", {
				text = "",
				texthl = "DebugHighlight",
				linehl = "",
				numhl = "DebugHighlight",
			})

			-- Ruby
			require("dap-ruby").setup()
			-- Golang
			require("dap-go").setup({})

			-- Slick UI which is automatically triggered when debugging
			dapui.setup({
				layouts = {
					{
						elements = {
							"scopes",
							"breakpoints",
							"stacks",
						},
						size = 35,
						position = "left",
					},
					{
						elements = {
							"repl",
						},
						size = 0.30,
						position = "bottom",
					},
				},
			})
			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			dap.set_log_level("TRACE")
			require("nvim-dap-virtual-text").setup({})
		end,
	},
}
