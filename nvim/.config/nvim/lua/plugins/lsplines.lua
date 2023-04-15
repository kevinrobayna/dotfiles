return {
	"Maan2003/lsp_lines.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = function()
		vim.diagnostic.config({
			virtual_text = false,
		})
		return {}
	end,
}
