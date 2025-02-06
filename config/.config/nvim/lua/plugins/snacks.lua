return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      hidden = true,
      sources = {
        files = { hidden = true },
      },
    },
  },
  keys = {
    {
      "<leader>fr",
      function()
        Snacks.picker.recent({ filter = { cwd = true } })
      end,
      desc = "Recent (cwd)",
    },
  },
}
