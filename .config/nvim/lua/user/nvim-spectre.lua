local status, spectre = pcall(require, "spectre")
if not status then
	return
end

spectre.setup({
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
