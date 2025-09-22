return {
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
  },
  {
    "laytan/cloak.nvim",
    event = "BufReadPre",
    opts = {
      patterns = {
        {
          -- Match any file starting with '.env'.
          -- This can be a table to match multiple file patterns.
          file_pattern = ".env*",
          -- Match an equals sign and any character after it.
          -- This can also be a table of patterns to cloak,
          -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
          cloak_pattern = "=.+",
          -- A function, table or string to generate the replacement.
          -- The actual replacement will contain the 'cloak_character'
          -- where it doesn't cover the original text.
          -- If left empty the legacy behavior of keeping the first character is retained.
          replace = nil,
        },
        {
          file_pattern = ".secrets",
          cloak_pattern = "=.+",
          replace = nil,
        },
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator", -- tmux & split window navigation
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        xml = { "xmlformat" },
        json = { "jq" },
        jsonl = { "jq" },
        toml = { "taplo" },
        yaml = { "yq" },
        lua = { "stylua" },
        sql = { "pg_format" },
        jsonnet = { "jsonnetfmt" },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "shfmt",
        "jq",
        "yamlfix",
        "yamlfmt",
        "yamllint",
        "buf",
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "VeryLazy", -- You can make it lazy-loaded via VeryLazy, but comment out if anything doesn’t work
    init = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
    end,
    opts = {
      provider_selector = function()
        return { "lsp", "indent" }
      end,
    },
  },
}
