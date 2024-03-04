return {
  "FabijanZulj/blame.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    merge_consecutive = true,
    virtual_style = "float",
  },
  keys = {
    { "<leader>gb", "<cmd>ToggleBlame<cr>", desc = "Toggle Git Blame UI" },
  },
}
