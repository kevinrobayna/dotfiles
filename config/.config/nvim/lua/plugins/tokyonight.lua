return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = function()
		require("tokyonight").setup({
			style = "moon",
			transparent = true,
			styles = {
				sidebars = "transparent",
				-- NOTE: this is an option but i don't think having the floats with a backgrund hurts
				-- floats = "transparent",
			},
		})
		vim.cmd([[colorscheme tokyonight]])
	end,
}
