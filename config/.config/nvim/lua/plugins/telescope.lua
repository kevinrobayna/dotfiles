return {
  {
    "telescope.nvim",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        config = function()
          require("telescope").load_extension("harpoon")
        end,
      },
    },
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fr",
        function()
          require("telescope.builtin").oldfiles({
            cwd = require("lazyvim.util").root.get(),
            include_current_session = true,
          })
        end,
        desc = "Find Recents",
      },
      -- Harpoon
      { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "Harpoon file" },
      { "<leader>sm", "<cmd>Telescope harpoon marks<cr>", desc = "Harpoon (Telescope)" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
}
