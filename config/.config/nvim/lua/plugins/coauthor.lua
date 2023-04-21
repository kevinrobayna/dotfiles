return {
	"2kabhishek/co-author.nvim",
	cmd = "GitCoAuhors",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"stevearc/dressing.nvim",
	},
	keys = {
		{ "<leader>ga", "<cmd>GitCoAuhors<cr>", desc = "GitCoAuhors" },
	},
}
