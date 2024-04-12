return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      xml = { "xmlformat" },
      eruby = { "erb-format" },
      json = { "jq" },
      toml = { "taplo" },
      yaml = { "yq" },
      lua = { "stylua" },
      ruby = { "standardrb" },
      markdown = { "markdownlint-cli2" },
      norg = { "markdownlint-cli2" },
      sql = { "sqlfmt" },
      jsonnet = { "jsonnetfmt" },
    },
  },
}
