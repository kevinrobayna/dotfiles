return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = function()
		vim.cmd([[colorscheme tokyonight]])
	end,
}
