return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
        },
        -- sorbet = {
        --   mason = false,
        --   cmd = { vim.fn.expand("~/.rbenv/shims/srb"), "--lsp" },
        -- },
        rubocop = {
          mason = false,
          cmd = { vim.fn.expand("~/.rbenv/shims/rubocop"), "--lsp" },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-vim-test",
      "stevearc/overseer.nvim",
      "olimorris/neotest-rspec",
    },
    opts = function(_, opts)
      opts.adapters = vim.list_extend(opts.adapters or {}, {
        require("neotest-vim-test")({
          ignore_file_types = { "ruby", "go" },
        }),
        require("neotest-rspec")({
          rspec_cmd = function()
            return vim.tbl_flatten({
              "bundle",
              "exec",
              "rspec",
            })
          end,
        }),
      })

      opts.consumers = vim.list_extend(opts.consumers or {}, {
        overseer = require("neotest.consumers.overseer"),
      })
    end,
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
        "jsonnet",
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
        "ruby",
        "tmux",
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
