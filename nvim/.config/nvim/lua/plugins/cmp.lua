return {
	"hrsh7th/nvim-cmp",
	version = false, -- last release is way too old
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lua",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
		{
			"zbirenbaum/copilot-cmp",
			dependencies = "copilot.lua",
			config = function(_, opts)
				local copilot_cmp = require("copilot_cmp")
				copilot_cmp.setup(opts)
				-- attach cmp source whenever copilot attaches
				-- fixes lazy-loading issues with the copilot cmp source
				require("core.util").on_attach(function(client)
					if client.name == "copilot" then
						copilot_cmp._on_insert_enter()
					end
				end)
			end,
		},
	},
	opts = function()
		local cmp = require("cmp")
		return {
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
				["<S-CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{
					name = "copilot",
					max_item_count = 3,
				},
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "nvim_lua" },
				{ name = "nvim_lsp_signature_help" },
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				kind_icons = require("core").icons.kind,
				duplicates_default = 0,
				format = function(_, item)
					local icons = require("core").icons.kind
					local icon = icons[item.kind] or item.kind

					item.menu = item.kind
					item.kind = icon

					return item
				end,
			},

			experimental = {
				ghost_text = {
					hl_group = "LspCodeLens",
				},
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					require("copilot_cmp.comparators").prioritize,

					-- Below is the default comparitor list and order for nvim-cmp
					cmp.config.compare.offset,
					-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
		}
	end,
}
