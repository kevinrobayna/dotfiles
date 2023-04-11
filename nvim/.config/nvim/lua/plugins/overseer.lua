return {
	"stevearc/overseer.nvim", -- Task runner and job management
	keys = {
		{
			"<leader>tr",
			function()
				local overseer = require("overseer")
				local tasks = overseer.list_tasks({ recent_first = true })
				if vim.tbl_isempty(tasks) then
					vim.notify("No tasks found", vim.log.levels.WARN)
				else
					overseer.run_action(tasks[1], "restart")
				end
			end,
			desc = "Rerun last",
		},
		{ "<leader>to", "<cmd>OverseerToggle<cr>", desc = "Tasks" },
	},
	opts = {
		component_aliases = {
			default_neotest = {
				"on_output_summarize",
				"on_exit_set_status",
				"on_complete_dispose",
			},
		},
		templates = { "java_build" },
	},
}
