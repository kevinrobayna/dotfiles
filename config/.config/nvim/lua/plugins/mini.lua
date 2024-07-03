return {
  "echasnovski/mini.icons",
  opts = {},
  lazy = true,
  specs = {
    { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
  },
  init = function()
    package.preload["nvim-web-devicons"] = function()
      local Icons = require("mini.icons")
      local ret = {}
      package.loaded["nvim-web-devicons"] = ret
      Icons.mock_nvim_web_devicons()

      local function get(cat)
        local all = {}
        for _, name in ipairs(Icons.list(cat)) do
          local icon, color = ret.get_icon_color(cat == "file" and name, cat == "extension" and name)
          all[name] = { icon = icon, color = color }
        end
        return all
      end

      ret.get_icons_by_extension = function()
        return get("extension")
      end

      ret.get_icons_by_filename = function()
        return get("file")
      end

      ret.get_icons = function()
        return vim.tbl_extend("force", get("file"), get("extension"))
      end
      return ret
    end
  end,
}
