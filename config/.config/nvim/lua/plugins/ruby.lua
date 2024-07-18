vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "rubocop"

local lsp = vim.g.lazyvim_ruby_lsp or "ruby_lsp"
if vim.fn.has("nvim-0.10") == 0 then
  -- ruby_lsp does not work well with Neovim < 0.10
  lsp = vim.g.lazyvim_ruby_lsp or "solarpath"
end
local formatter = vim.g.lazyvim_ruby_formatter or "rubocop"

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        ruby_lsp = {
          enabled = lsp == "ruby_lsp",
        },
        solargraph = {
          enabled = lsp == "solargraph",
        },
        rubocop = {
          enabled = formatter == "rubocop",
        },
        standardrb = {
          enabled = formatter == "standardrb",
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ruby = { formatter },
        eruby = { "erb-format" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "olimorris/neotest-rspec",
    },
    opts = {
      adapters = {
        ["neotest-rspec"] = {
          rspec_cmd = function()
            return vim.tbl_flatten({
              "bundle",
              "exec",
              "rspec",
            })
          end,
        },
      },
    },
  },
}
