return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- NOTE: this although not doing much is required! otherwise it will not work properly
    require("lsp_lines").setup()
  end,
}