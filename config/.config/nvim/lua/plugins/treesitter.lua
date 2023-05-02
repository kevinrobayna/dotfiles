return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "cmake",
        "css",
        "diff",
        "gitignore",
        "html",
        "http",
        "jsdoc",
        "jsonc",
        "lua",
        "luap",
        "markdown",
        "markdown_inline",
        "regex",
        "sql",
        "toml",
        "vim",
        "yaml",
        "dockerfile",
      },
      matchup = {
        enable = true,
      },
      highlight = { enable = true },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
  },
}
