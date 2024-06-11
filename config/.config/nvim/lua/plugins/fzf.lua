return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>fR", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
    { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
  },
}
