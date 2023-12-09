return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      json = { "jq" },
      yaml = { "yq" },
      xml = { "xmlformat" },
      ruby = { "bundle" },
      sql = { "sql_formatter" },
    },
    formatters = {
      bundle = {
        command = "bundle exec rubocop",
      },
    },
  },
}
