return {
  "nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
      { name = "emoji" },
      { name = "path" },
      { name = "cmdline" },
      { name = "nvim_lua" },
      { name = "nvim_lsp_signature_help" },
    }))
  end,
}
