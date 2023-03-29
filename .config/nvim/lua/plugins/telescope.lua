return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "ahmedkhalf/project.nvim" },
    },
    config = function()
      telescope = require("telescope")
      local actions = require("telescope.actions")
      local themes = require("telescope.themes")

      telescope.setup({
        -- configure custom mappings
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,                -- move to prev result
              ["<C-j>"] = actions.move_selection_next,                    -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            },
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim", -- add this value
            "--hidden",
            "--ignore",
            "--glob=!**/.git/*",
            "--glob=!**/.idea/*",
            "--glob=!**/node_modules/*",
            "--glob=!**/.next/*",
          },
        },
        extensions = {
          ["ui-select"] = {
            themes.get_dropdown({}),
          },
        },
        pickers = {
          find_files = {
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--ignore",
              "-u",
              "--glob=!**/.git/*",
              "--glob=!**/.idea/*",
              "--glob=!**/node_modules/*",
              "--glob=!**/.next/*",
            },
          },
        },
      })
      telescope.load_extension("ui-select")
      telescope.load_extension("live_grep_args")
      telescope.load_extension("projects")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    cmd = "Telescope",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
