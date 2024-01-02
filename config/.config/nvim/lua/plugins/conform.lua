return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      json = { "jq" },
      yaml = { "yq" },
      lua = { "stylua" },
      ruby = { "rubocop" },
    },
  },
}
