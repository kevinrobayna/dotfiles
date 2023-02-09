-- vim options
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

-- general
lvim.log.level = "info"
lvim.format_on_save = {
    enabled = true,
    pattern = "*.lua",
    timeout = 1000,
}

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.builtin.terminal.open_mapping = "<c-t>"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
    },
    -- for normal mode
    n = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
    },
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }


-- Change theme settings
lvim.colorscheme = "catppuccin-mocha"

-- After changing plugin config exit and reopen LunarVim, Run :PackerSync
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- enable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = true

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
}

-- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
    {
        "sindrets/diffview.nvim",
        event = "BufRead",
    },
    {
        "f-person/git-blame.nvim",
        event = "BufRead",
        config = function()
          vim.cmd "highlight default link gitblame SpecialComment"
          vim.g.gitblame_enabled = 0
        end,
    },
    { "ThePrimeagen/harpoon" },
    { "catppuccin/nvim" }
}

-- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
vim.api.nvim_create_autocmd("FileType", {
    pattern = "zsh",
    callback = function()
      -- let treesitter use bash highlight for zsh files as well
      require("nvim-treesitter.highlight").attach(0, "bash")
    end,
})


------------------------
-- Harpoon
------------------------
local harpoon = require "harpoon"
require("telescope").load_extension('harpoon')
harpoon.setup {
    menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
    }
}
lvim.keys.normal_mode["<leader>a"] = require("harpoon.mark").add_file
lvim.keys.normal_mode["<C-e>"] = require("harpoon.ui").toggle_quick_menu

lvim.keys.normal_mode["<C-h>"] = function() require("harpoon.ui").nav_file(1) end
lvim.keys.normal_mode["<C-j>"] = function() require("harpoon.ui").nav_file(2) end
lvim.keys.normal_mode["<C-k>"] = function() require("harpoon.ui").nav_file(3) end
lvim.keys.normal_mode["<C-l>"] = function() require("harpoon.ui").nav_file(4) end
