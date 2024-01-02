return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      json = { "jq" },
      toml = { "taplo" },
      yaml = { "yq" },
      lua = { "stylua" },
      ruby = { "rubocop" },
    },
  },
}
