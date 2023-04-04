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
			{
				"folke/neodev.nvim",
				opts = {
					library = { plugins = { "nvim-dap-ui" }, types = true },
				},
			},
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
				text = require("core").icons.ui.Bug,
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			})
			vim.fn.sign_define("DapBreakpointRejected", {
				text = require("core").icons.ui.Bug,
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			})
			vim.fn.sign_define("DapStopped", {
				text = require("core").icons.ui.BoldArrowRight,
				texthl = "DiagnosticSignWarn",
				linehl = "Visual",
				numhl = "DiagnosticSignWarn",
			})

			-- Ruby
			require("dap-ruby").setup()
			-- Golang
			require("dap-go").setup({})

			-- Slick UI which is automatically triggered when debugging
			dapui.setup({
				icons = { expanded = "", collapsed = "", circular = "" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				-- Use this to override mappings for specific elements
				element_mappings = {},
				expand_lines = true,
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.33 },
							{ id = "breakpoints", size = 0.17 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 0.33,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.45 },
							{ id = "console", size = 0.55 },
						},
						size = 0.27,
						position = "bottom",
					},
				},
				controls = {
					enabled = true,
					-- Display controls in this element
					element = "repl",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "",
						terminate = "",
					},
				},
				floating = {
					max_height = 0.9,
					max_width = 0.5, -- Floats will be treated as percentage of your screen.
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil, -- Can be integer or nil.
					max_value_lines = 100, -- Can be integer or nil.
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
