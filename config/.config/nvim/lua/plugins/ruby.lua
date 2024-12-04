return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruby_lsp = {
        mason = false,
        cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
      },
      sorbet = {
        mason = false,
        cmd = { vim.fn.expand("~/.rbenv/shims/srb"), "--lsp" },
      },
      rubocop = {
        mason = false,
        cmd = { vim.fn.expand("~/.rbenv/shims/rubocop"), "--lsp" },
      },
    },
  },
}
