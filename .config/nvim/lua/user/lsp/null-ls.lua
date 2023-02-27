local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.jq,
		formatting.stylua,
		formatting.gofmt,
		formatting.gofumpt,
		formatting.buf,
		require("null-ls").builtins.formatting.rubocop.with({
			command = "bundle",
			args = vim.list_extend({ "exec", "rubocop" }, require("null-ls").builtins.formatting.rubocop._opts.args),
		}),
		diagnostics.golangci_lint,
		require("null-ls").builtins.diagnostics.rubocop.with({
			command = "bundle",
			args = vim.list_extend({ "exec", "rubocop" }, require("null-ls").builtins.diagnostics.rubocop._opts.args),
		}),
		diagnostics.zsh,
		diagnostics.mdl,
		diagnostics.buf,
	},
})
