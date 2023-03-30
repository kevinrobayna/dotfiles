return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = {
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				},
			},
			-- add operators that will trigger motion and text object completion
			-- to enable all native operators, set the preset / operators plugin above
			-- operators = { gc = "Comments" },
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
			show_help = true, -- show help message on the command line when the popup is visible
			triggers_blacklist = {
				-- list of mode / prefixes that should never be hooked by WhichKey
				-- this is mostly relevant for key maps that start with a native binding
				-- most people should not need to change this
				i = { "j", "k" },
				v = { "j", "k" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			local keymaps = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["w"] = { "<cmd>w!<CR>", "Save" },
				["q"] = { "<cmd>qa!<CR>", "Quit" },
				["<leader>b"] = { name = "buffer" },
				["<leader>c"] = { name = "code" },
				["<leader>f"] = { name = "file/find" },
				["<leader>g"] = { name = "git" },
				["<leader>q"] = { name = "quit/session" },
				["<leader>s"] = { name = "search" },
				["<leader>u"] = { name = "ui" },
				["<leader>t"] = { name = "tests" },
				["<leader>x"] = { name = "diagnostics/quickfix" },
				["<leader>sn"] = { name = "noice" },
			}
			wk.register(keymaps)
		end,
	},
}
