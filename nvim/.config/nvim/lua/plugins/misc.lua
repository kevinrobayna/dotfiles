return {
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
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
		keys = {
			{
				"<C-a>",
				function()
					return require("dial.map").inc_normal()
				end,
				expr = true,
				desc = "Increment",
			},
			{
				"<C-x>",
				function()
					return require("dial.map").dec_normal()
				end,
				expr = true,
				desc = "Decrement",
			},
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
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},
	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>m", "<cmd>MaximizerToggle!<cr>", desc = "Toggle split Window maximization" },
		},
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = {
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				},
			},
			icons = {
				breadcrumb = require("core").icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
				separator = require("core").icons.ui.BoldArrowRight, -- symbol used between a key and it's label
				group = require("core").icons.ui.Plus, -- symbol prepended to a group
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
				["<leader>vs"] = { "<cmd>vsplit<CR>", "Vertical Split" },
				["<leader>hs"] = { "<cmd>split<CR>", "Horizontal Split" },
				["<leader>w"] = { "<cmd>w<CR>", "Save" },
				["<leader>q"] = { "<cmd>q<CR>", "Quit" },
				["<leader>b"] = { name = "buffer" },
				["<leader>c"] = { name = "code" },
				["<leader>f"] = { name = "file/find" },
				["<leader>g"] = { name = "git" },
				["<leader>s"] = { name = "search" },
				["<leader>t"] = { name = "Tests (NeoTest)" },
				["<leader>d"] = { name = "Debug (DAP)" },
				["<leader>x"] = { name = "diagnostics/quickfix" },
				["<leader>sn"] = { name = "noice" },
			}
			wk.register(keymaps)
		end,
	},
}
