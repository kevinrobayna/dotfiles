return {
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
}
