local Util = require("lazyvim.util")

return {
  {
    "zbirenbaum/copilot.lua",
    cond = function()
      local cwd = Util.root.cwd()
      return string.match(cwd, "dev")
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cond = function()
      local cwd = Util.root.cwd()
      return string.match(cwd, "dev")
    end,
  },
}
