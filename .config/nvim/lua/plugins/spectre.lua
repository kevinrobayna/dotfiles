return {
	"windwp/nvim-spectre",
	keys = {
		{
			"<leader>sr",
			function()
				require("spectre").open()
			end,
			desc = "Replace in files (Spectre)",
		},
	},
	config = function()
		require("spectre").setup({
			live_update = true,
			find_engine = {
				["rg"] = {
					cmd = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--hidden",
						"--ignore",
						"-u",
						"--glob=!**/.git/*",
						"--glob=!**/.idea/*",
						"--glob=!**/node_modules/*",
						"--glob=!**/.next/*",
					},
				},
			},
		})
	end,
}
