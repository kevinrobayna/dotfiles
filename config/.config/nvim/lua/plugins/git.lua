return {
  -- Better Commit Message UI
  {
    "rhysd/committia.vim",
    event = "BufReadPre",
  },
  -- Be able to tag co co-authors
  {
    "2kabhishek/co-author.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = { "CoAuthor" },
  },
  -- Blame UI
  {
    "FabijanZulj/blame.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      merge_consecutive = true,
      virtual_style = "float",
    },
    keys = {
      { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Toggle Git Blame UI" },
    },
  },
  -- Open file in GH
  {
    "tyru/open-browser-github.vim",
    dependencies = {
      "tyru/open-browser.vim",
    },
    keys = {
      { "<leader>co", "<Cmd>OpenGithubFile<CR>", desc = "Open in Github" },
    },
  },
}
