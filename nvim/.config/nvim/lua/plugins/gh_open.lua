return {
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
}
