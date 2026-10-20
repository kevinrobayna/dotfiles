return {
  {
    "tokyonight.nvim",
    opts = function()
      return {
        style = "moon",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      }
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        sources = {
          files = { hidden = true },
          -- The sidebar's hidden layout windows make vim-tmux-navigator's
          -- `wincmd` succeed, so it never hands off to tmux. Go to tmux directly.
          explorer = {
            actions = (function()
              local actions = {}
              for dir, flag in pairs({ left = "L", down = "D", up = "U" }) do
                actions["tmux_" .. dir] = function()
                  if vim.env.TMUX then
                    vim.fn.system({ "tmux", "select-pane", "-t", vim.env.TMUX_PANE, "-" .. flag })
                  end
                end
              end
              return actions
            end)(),
            win = {
              list = {
                keys = {
                  ["<c-h>"] = "tmux_left",
                  ["<c-j>"] = "tmux_down",
                  ["<c-k>"] = "tmux_up",
                },
              },
            },
          },
        },
      },
      image = {},
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
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
    },
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      local colors = require("tokyonight.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
            InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
}
