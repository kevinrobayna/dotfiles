return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      xml = { "xmlformat" },
      json = { "jq" },
      jsonl = { "jq" },
      toml = { "taplo" },
      yaml = { "yq" },
      lua = { "stylua" },
      sql = { "pg_format" },
      jsonnet = { "jsonnetfmt" },
    },
  },
}
