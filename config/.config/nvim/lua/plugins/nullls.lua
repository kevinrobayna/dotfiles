return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")
    vim.list_extend(opts.sources, {
      nls.builtins.code_actions.refactoring,
      nls.builtins.code_actions.gitsigns,
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.jq,
      nls.builtins.formatting.yq,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.mdformat,
      nls.builtins.formatting.buf,
      nls.builtins.formatting.xmllint,
      nls.builtins.formatting.sqlfmt,
      nls.builtins.diagnostics.zsh,
      nls.builtins.diagnostics.mdl,
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.buf,
    })
  end,
}
