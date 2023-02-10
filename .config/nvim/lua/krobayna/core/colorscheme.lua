-- import nvim-autopairs safely
local setup, catppuccin = pcall(require, "catppuccin")
if not setup then
	return
end

catppuccin.setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	integrations = {
		gitsigns = true,
		harpoon = true,
		lsp_saga = true,
		cmp = true,
		mason = true,
		neotree = true,
		dap = true,
		nvimtree = true,
		treesitter_context = true,
		treesitter = true,
		telescope = true,
		which_key = true,
	},
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
