return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	opts = {
		signcolumn = true,
		signs = {
			add = { text = require("core").icons.git.LineAdded },
			change = { text = require("core").icons.git.LineModified },
			delete = { text = require("core").icons.git.LineRemoved },
			topdelete = { text = require("core").icons.git.LineRemoved },
			changedelete = { text = require("core").icons.git.LineModified },
			untracked = { text = require("core").icons.git.FileUntracked },
		},
	},
}
