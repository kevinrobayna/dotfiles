local neotest_setup, neotests = pcall(require, "neotest")
if not neotest_setup then
	return
end

neotests.setup({
	adapters = {
		require("neotest-rspec")({
			rspec_cmd = function()
				return vim.tbl_flatten({
					"bundle",
					"exec",
					"rspec",
				})
			end,
		}),

		require("neotest-vim-test")({
			ignore_file_types = { "ruby" },
		}),
	},
})
