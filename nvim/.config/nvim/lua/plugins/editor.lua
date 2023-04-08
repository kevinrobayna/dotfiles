local Util = require("core/util")

return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			char = "│",
			show_trailing_blankline_indent = false,
			show_first_indent_level = true,
			use_treesitter = true,
			show_current_context = true,
			buftype_exclude = { "terminal", "nofile" },
			filetype_exclude = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy" },
		},
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"moll/vim-bbye",
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		},
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("core").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warning .. diag.warning or "")
					return vim.trim(ret)
				end,
				close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				offsets = {
					{
						filetype = "NvimTree",
						text = "",
						highlight = "Directory",
						padding = 1,
					},
				},
				separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
			},
			highlights = {
				fill = {
					fg = { attribute = "fg", highlight = "#ff0000" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				background = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				buffer_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				close_button = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				close_button_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				tab_selected = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},

				tab = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				tab_close = {
					-- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
					fg = { attribute = "fg", highlight = "TabLineSel" },
					bg = { attribute = "bg", highlight = "Normal" },
				},

				duplicate_selected = {
					fg = { attribute = "fg", highlight = "TabLineSel" },
					bg = { attribute = "bg", highlight = "TabLineSel" },
					italic = true,
				},

				duplicate_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
					italic = true,
				},

				duplicate = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
					italic = true,
				},

				modified = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				modified_selected = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},

				modified_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				separator = {
					fg = { attribute = "bg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				separator_selected = {
					fg = { attribute = "bg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},

				indicator_selected = {
					fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
			},
		},
	},
	{
		"f-person/git-blame.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signcolumn = true,
			signs = {
				add = {
					hl = "GitSignsAdd",
					text = require("core").icons.ui.BoldLineLeft,
					numhl = "GitSignsAddNr",
					linehl = "GitSignsAddLn",
				},
				change = {
					hl = "GitSignsChange",
					text = require("core").icons.ui.BoldLineLeft,
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = {
					hl = "GitSignsDelete",
					text = require("core").icons.ui.Triangle,
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				topdelete = {
					hl = "GitSignsDelete",
					text = require("core").icons.ui.Triangle,
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = require("core").icons.ui.BoldLineLeft,
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
			},
		},
	},
	{
		"tyru/open-browser-github.vim",
		dependencies = {
			"tyru/open-browser.vim",
		},
		cmd = {
			"OpenGithubFile",
			"OpenGithubIssue",
			"OpenGithubPullReq",
			"OpenGithubProject",
		},
		keys = {
			{ "<leader>co", "<Cmd>OpenGithubFile<CR>", desc = "Open in Github" },
		},
	},

	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {

			providers = {
				"lsp",
				"treesitter",
				"regex",
			},
			delay = 200,
			filetypes_denylist = {
				"dirvish",
				"fugitive",
				"NvimTree",
				"lazy",
				"neogitstatus",
				"Trouble",
				"lir",
				"Outline",
				"spectre_panel",
				"toggleterm",
				"DressingSelect",
				"TelescopePrompt",
			},
			filetypes_allowlist = {},
			modes_denylist = {},
			modes_allowlist = {},
			providers_regex_syntax_denylist = {},
			providers_regex_syntax_allowlist = {},
			under_cursor = true,
		},
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function(...)
			local icons = require("core").icons
			local function fg(name)
				return function()
					---@type {foreground?:number}?
					local hl = vim.api.nvim_get_hl_by_name(name, true)
					return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
				end
			end

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.BoldError,
								warn = icons.diagnostics.BoldWarning,
								info = icons.diagnostics.BoldInformation,
								hint = icons.diagnostics.BoldHint,
							},
						},
						{
							"filetype",
							icon_only = true,
							separator = "",
							padding = {
								left = 1,
								right = 0,
							},
						},
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
						{
							function()
								return require("nvim-navic").get_location()
							end,
							cond = function()
								return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end,
						},
					},
					lualine_x = {
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = fg("Special"),
						},
						{
							"diff",
							symbols = {
								added = icons.git.LineAdded,
								modified = icons.git.LineModified,
								removed = icons.git.LineRemoved,
							},
						},
						{ "encoding" },
						{
							"fileformat",
							symbols = {
								unix = "", -- e712
								dos = "", -- e70f
								mac = "", -- e711
							},
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						{
							"filetype",
							icon_only = false,
						},
					},
				},
				extensions = { "nvim-tree", "nvim-dap-ui", "toggleterm", "trouble" },
			}
		end,
	},
	{
		"SmiteshP/nvim-navic",
		lazy = true,
		init = function()
			vim.g.navic_silence = true
			require("core.util").on_attach(function(client, buffer)
				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, buffer)
				end
			end)
		end,
		opts = function()
			return {
				separator = " ",
				highlight = true,
				depth_limit = 5,
				icons = require("core").icons.kind,
			}
		end,
	},

	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		config = function()
			local scrollbar = require("scrollbar")
			local colors = require("tokyonight.colors").setup()
			scrollbar.setup({
				handle = { color = colors.bg_highlight },
				excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
				marks = {
					Search = { color = colors.orange },
					Error = { color = colors.error },
					Warn = { color = colors.warning },
					Info = { color = colors.info },
					Hint = { color = colors.hint },
					Misc = { color = colors.purple },
				},
			})
		end,
	},
	-- floating winbar
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		config = function()
			local colors = require("tokyonight.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
						InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
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
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
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
			{
				"<leader>sg",
				":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
				desc = "Find in Files (Grep)",
			},
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
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				-- configure custom mappings
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					layout_strategy = "horizontal",
					layout_config = { prompt_position = "top" },
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
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--trim", -- add this value
						"--hidden",
						"--ignore",
						"--glob=!**/.git/*",
						"--glob=!**/.idea/*",
						"--glob=!**/node_modules/*",
						"--glob=!**/.next/*",
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
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
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
			telescope.load_extension("ui-select")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("projects")
			telescope.load_extension("harpoon")
			telescope.load_extension("undo")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		opts = {
			size = 20,
			open_mapping = [[<c-t>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
			},
		},
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
			{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").previous({ skip_groups = true, jump = true })
					else
						vim.cmd.cprev()
					end
				end,
				desc = "Previous trouble/quickfix item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						vim.cmd.cnext()
					end
				end,
				desc = "Next trouble/quickfix item",
			},
		},
	},
	{
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
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
		},
		opts = function()
			return {
				update_focused_file = {
					enable = true,
				},
				renderer = {
					root_folder_modifier = ":t",
					icons = {
						git_placement = "before",
						padding = " ",
						symlink_arrow = " ➛ ",
						glyphs = {
							default = require("core").icons.ui.Text,
							symlink = require("core").icons.ui.FileSymlink,
							bookmark = require("core").icons.ui.BookMark,
							folder = {
								arrow_closed = require("core").icons.ui.TriangleShortArrowRight,
								arrow_open = require("core").icons.ui.TriangleShortArrowDown,
								default = require("core").icons.ui.Folder,
								open = require("core").icons.ui.FolderOpen,
								empty = require("core").icons.ui.EmptyFolder,
								empty_open = require("core").icons.ui.EmptyFolderOpen,
								symlink = require("core").icons.ui.FolderSymlink,
								symlink_open = require("core").icons.ui.FolderOpen,
							},
							git = {
								unstaged = require("core").icons.git.FileUnstaged,
								staged = require("core").icons.git.FileStaged,
								unmerged = require("core").icons.git.FileUnmerged,
								renamed = require("core").icons.git.FileRenamed,
								untracked = require("core").icons.git.FileUntracked,
								deleted = require("core").icons.git.FileDeleted,
								ignored = require("core").icons.git.FileIgnored,
							},
						},
					},
				},

				diagnostics = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
					debounce_delay = 50,
					severity = {
						min = vim.diagnostic.severity.HINT,
						max = vim.diagnostic.severity.ERROR,
					},
					icons = {
						hint = require("core").icons.diagnostics.BoldHint,
						info = require("core").icons.diagnostics.BoldInformation,
						warning = require("core").icons.diagnostics.BoldWarning,
						error = require("core").icons.diagnostics.BoldError,
					},
				},
				view = {
					adaptive_size = true,
					side = "left",
					mappings = {
						list = {
							{ key = { "l", "<CR>", "o" }, cb = require("nvim-tree.config").nvim_tree_callback("edit") },
							{ key = "h", cb = require("nvim-tree.config").nvim_tree_callback("close_node") },
							{ key = "v", cb = require("nvim-tree.config").nvim_tree_callback("vsplit") },
						},
					},
				},
			}
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
			{ "rcarriga/nvim-notify" },
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
    -- stylua: ignore
    keys = {
      {
        "<S-Enter>",
        function() require("noice").redirect(vim.fn.getcmdline()) end,
        mode = "c",
        desc = "Redirect Cmdline"
      },
      {
        "<leader>snl",
        function() require("noice").cmd("last") end,
        desc = "Noice Last Message"
      },
      {
        "<leader>snh",
        function() require("noice").cmd("history") end,
        desc = "Noice History"
      },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      {
        "<c-f>",
        function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" }
      },
      {
        "<c-b>",
        function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" }
      },
    },
	},
}
