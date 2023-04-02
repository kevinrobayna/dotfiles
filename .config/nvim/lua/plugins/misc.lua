return {
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},
	{
		"cshuaimin/ssr.nvim",
		keys = {
			{
				"<leader>sR",
				function()
					require("ssr").open()
				end,
				mode = { "n", "x" },
				desc = "Structural Replace",
			},
		},
	},
	{
		"monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
				},
			})
		end,
	},
}
