return {
	{
		"f-person/git-blame.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signcolumn = true,
			signs = {
				add = {
					hl = "GitSignsAdd",
					text = require("core").icons.ui.BoldLineLeft,
					numhl = "GitSignsAddNr",
					linehl = "GitSignsAddLn",
				},
				change = {
					hl = "GitSignsChange",
					text = require("core").icons.ui.BoldLineLeft,
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = {
					hl = "GitSignsDelete",
					text = require("core").icons.ui.Triangle,
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				topdelete = {
					hl = "GitSignsDelete",
					text = require("core").icons.ui.Triangle,
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = require("core").icons.ui.BoldLineLeft,
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
			},
		},
	},
	{
		"tyru/open-browser-github.vim",
		dependencies = {
			"tyru/open-browser.vim",
		},
		cmd = {
			"OpenGithubFile",
			"OpenGithubIssue",
			"OpenGithubPullReq",
			"OpenGithubProject",
		},
		keys = {
			{ "<leader>co", "<Cmd>OpenGithubFile<CR>", desc = "Open in Github" },
		},
	},
}
