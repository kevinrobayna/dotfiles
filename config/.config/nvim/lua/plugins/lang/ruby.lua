return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ruby" })
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "olimorris/neotest-rspec",
    },
    opts = function(_, opts)
      -- Would like "cleaner" way than this..
      opts.adapters = vim.list_extend(opts.adapters or {}, {
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
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "solargraph",
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.rubocop.with({
          command = "bundle",
          args = vim.list_extend({ "exec", "rubocop" }, nls.builtins.formatting.rubocop._opts.args),
        }),
        nls.builtins.diagnostics.rubocop.with({
          command = "bundle",
          args = vim.list_extend({ "exec", "rubocop" }, nls.builtins.diagnostics.rubocop._opts.args),
        }),
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solargraph = {},
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "suketa/nvim-dap-ruby",
      config = function()
        require("dap-ruby").setup()
      end,
    },
  },
}
