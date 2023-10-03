return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.gofmt,
        nls.builtins.formatting.gofumpt,

        nls.builtins.diagnostics.golangci_lint,
      })
    end,
  },
}
