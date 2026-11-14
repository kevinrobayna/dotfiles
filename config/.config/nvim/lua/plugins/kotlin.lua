-- Replaces LazyVim's lang.kotlin extra, which hard-wires fwcd's kotlin-language-server:
-- unmaintained, and it runs out of memory on large Gradle monorepos. kotlin_lsp is
-- JetBrains' IntelliJ-based server.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_lsp = {},
        -- mason-lspconfig auto-enables any installed server, so a leftover package would start it.
        kotlin_language_server = { enabled = false },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "kotlin-lsp", "ktlint" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "kotlin" } },
  },
  {
    "mfussenegger/nvim-lint",
    opts = { linters_by_ft = { kotlin = { "ktlint" } } },
  },
  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { kotlin = { "ktlint" } } },
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "weilbith/neotest-gradle" },
    opts = { adapters = { "neotest-gradle" } },
  },
}
