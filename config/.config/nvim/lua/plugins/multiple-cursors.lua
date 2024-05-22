return {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*", -- Use the latest tagged version
  opts = {}, -- This causes the plugin setup function to be called
  keys = {
    { "<C-L>", "<Cmd>MultipleCursorsAddDown<CR>" },
    { "<C-B>", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" } },
  },
}
