return {
  "tpope/vim-projectionist",
  event = "BufReadPre",
  cmd = "A",
  keys = {
    { "<C-t>", "<esc><cmd>A<cr>", desc = "Alternate File" },
  },
  config = function()
    vim.g.projectionist_heuristics = {
      -- Matched against every parent directory, so the nearest Gradle module wins in a monorepo.
      ["build.gradle.kts|build.gradle"] = {
        ["src/main/kotlin/*.kt"] = { type = "src", alternate = "src/test/kotlin/{}Test.kt" },
        ["src/test/kotlin/*Test.kt"] = { type = "test", alternate = "src/main/kotlin/{}.kt" },
      },
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
            "RSpec.describe {} do",
            "end",
          },
        },
      },
    }
  end,
}
