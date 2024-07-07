return {
  "tpope/vim-projectionist",
  event = "BufReadPre",
  cmd = "A",
  -- TODO: this does not work for now
  -- keys = {
  --   { "C-t", "<cmd>A<cr>", desc = "Alternate File" },
  --   { "C-T", "<cmd>AV<cr>", desc = "Alternate File" },
  -- },
  config = function()
    vim.g.projectionist_heuristics = {
      [".ruby-version"] = {
        ["app/*.rb"] = {
          type = "src",
          alternate = "spec/{}_spec.rb",
          template = {
            "# frozen_string_literal: true",
            "",
            "# app/{}.rb",
            "class {} do",
            "end",
          },
        },
        ["lib/*.rb"] = {
          type = "lib",
          alternate = "spec/{}_spec.rb",
          template = {
            "# lib/{}.rb",
            "class {} do",
            "end",
          },
        },
        ["spec/*_spec.rb"] = {
          type = "spec",
          alternate = { "app/{}.rb", "lib/{}.rb" },
          template = {
            "# frozen_string_literal: true",
            "",
            'require "spec_helper"',
            "",
            "# spec/{}_spec.rb",
            "Rspec.describe {} do",
            "end",
          },
        },
      },
    }
  end,
}
