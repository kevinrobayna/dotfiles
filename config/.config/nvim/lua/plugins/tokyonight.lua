return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = function()
		require("tokyonight").setup({
			style = "moon",
		})
		vim.cmd([[colorscheme tokyonight]])
	end,
}
