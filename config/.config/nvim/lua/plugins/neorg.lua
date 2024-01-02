return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "folke/zen-mode.nvim",
  },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/dev/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
            name = "[neorg]",
          },
        },
        ["core.integrations.treesitter"] = {}
      },
    })
  end,
}
