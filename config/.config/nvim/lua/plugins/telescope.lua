local Util = require("core/util")

return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = vim.fn.executable("make") == 1,
		},
		{ "ahmedkhalf/project.nvim" },
		{ "ThePrimeagen/harpoon" },
		{ "debugloop/telescope-undo.nvim" },
	},
	keys = {
		{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
		{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		{ "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
		-- find
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
		{ "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
		{ "<leader>fr", Util.telescope("oldfiles"), desc = "Recent" },
		-- git
		{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
		{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
		{ "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "branches" },
		-- search
		{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
		{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
		{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
		{ "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
		{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
		{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
		{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
		{ "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
		{ "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
		{
			"<leader>ss",
			Util.telescope("lsp_document_symbols", {
				symbols = {
					"Class",
					"Function",
					"Method",
					"Constructor",
					"Interface",
					"Module",
					"Struct",
					"Trait",
					"Field",
					"Property",
				},
			}),
			desc = "Goto Symbol",
		},
		{
			"<leader>sS",
			Util.telescope("lsp_workspace_symbols", {
				symbols = {
					"Class",
					"Function",
					"Method",
					"Constructor",
					"Interface",
					"Module",
					"Struct",
					"Trait",
					"Field",
					"Property",
				},
			}),
			desc = "Goto Symbol (Workspace)",
		},
		-- Harpoon
		{ "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "Harpoon file" },
		{ "<leader>sm", "<cmd>Telescope harpoon marks<cr>", desc = "Harpoon (Telescope)" },
		-- Undo
		{ "<leader>u", "<cmd>Telescope undo<CR>", desc = "Undo (telescope)" },
	},
	opts = {
		-- configure custom mappings
		defaults = {
			file_ignore_patterns = { ".git/", "node_modules" },
			prompt_prefix = " ",
			selection_caret = " ",
			path_display = { "smart" },
			layout_strategy = "horizontal",
			layout_config = {
				preview_width = 0.6,
				prompt_position = "top",
			},
			sorting_strategy = "ascending",
			winblend = 0,
			mappings = {
				i = {
					["<c-t>"] = function(...)
						return require("trouble.providers.telescope").open_with_trouble(...)
					end,
					["<a-t>"] = function(...)
						return require("trouble.providers.telescope").open_selected_with_trouble(...)
					end,
					["<a-i>"] = function()
						Util.telescope("find_files", { no_ignore = true })()
					end,
					["<a-h>"] = function()
						Util.telescope("find_files", { hidden = true })()
					end,
					["<C-Down>"] = function(...)
						return require("telescope.actions").cycle_history_next(...)
					end,
					["<C-Up>"] = function(...)
						return require("telescope.actions").cycle_history_prev(...)
					end,
					["<C-f>"] = function(...)
						return require("telescope.actions").preview_scrolling_down(...)
					end,
					["<C-b>"] = function(...)
						return require("telescope.actions").preview_scrolling_up(...)
					end,
				},
				n = {
					["q"] = function(...)
						return require("telescope.actions").close(...)
					end,
				},
			},
		},
		pickers = {
			buffers = {
				prompt_prefix = "﬘ ",
			},
			commands = {
				prompt_prefix = " ",
			},
			git_files = {
				prompt_prefix = " ",
				show_untracked = true,
			},
			find_files = {
				prompt_prefix = " ",
				find_command = { "rg", "--files", "--hidden" },
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
			undo = {
				side_by_side = true,
				layout_strategy = "vertical",
				layout_config = {
					preview_height = 0.8,
				},
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf")
		telescope.load_extension("notify")
		telescope.load_extension("harpoon")
	end,
}
