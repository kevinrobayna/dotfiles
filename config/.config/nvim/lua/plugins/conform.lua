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
      markdown = { "markdownlint-cli2" },
      norg = { "markdownlint-cli2" },
    },
  },
}
