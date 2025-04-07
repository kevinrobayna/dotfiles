local Util = require("lazyvim.util")

return {
  {
    "zbirenbaum/copilot.lua",
    -- FIXME: this needs to be removed soon :tm: just waiting for folke to merge
    -- https://github.com/LazyVim/LazyVim/pull/5900
    opts = function()
      require("copilot.api").status = require("copilot.status")
    end,
    --   cond = function()
    --     local cwd = Util.root.cwd()
    --     return string.match(cwd, "dev")
    --   end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    -- cond = function()
    --   local cwd = Util.root.cwd()
    --   return string.match(cwd, "dev")
    -- end,
  },
}
