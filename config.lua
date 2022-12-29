--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

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

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

------------------------
-- Trouble
------------------------
lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- Change theme settings
lvim.colorscheme = "lunar"

-- After changing plugin config exit and reopen LunarVim, Run :PackerSync
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.dap.active = true

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>
--- enable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = true

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "goimports", filetypes = { "go" } },
  { command = "gofumpt", filetypes = { "go" } },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
}

-- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "troubletoggle",
  },
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
  { "olexsmir/gopher.nvim" },
  { "leoluz/nvim-dap-go" },
}

-- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})


-- ------------------------
-- -- Dap
-- ------------------------
-- local dap_ok, dapgo = pcall(require, "dap-go")
-- if not dap_ok then
--   return
-- end

-- dapgo.setup()


-- local dap = require('dap')
-- dap.adapters.ruby = {
--   type = 'executable';
--   command = 'bundle';
--   args = { 'exec', 'readapt', 'stdio' };
-- }

-- dap.configurations.ruby = {
--   {
--     type = 'ruby';
--     request = 'launch';
--     name = 'Rails';
--     program = 'bundle';
--     programArgs = { 'exec', 'rails', 's' };
--     useBundler = true;
--   },
--   {
--     type = 'ruby';
--     request = 'launch';
--     name = "debug current file",
--     program = 'bundle';
--     programArgs = { 'exec', 'ruby', 's' };
--     useBundler = true;
--   }
-- }

-- ------------------------
-- -- LSP
-- ------------------------
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

-- local lsp_manager = require "lvim.lsp.manager"
-- lsp_manager.setup("golangci_lint_ls", {
--   on_init = require("lvim.lsp").common_on_init,
--   capabilities = require("lvim.lsp").common_capabilities(),
-- })

-- lsp_manager.setup("gopls", {
--   on_attach = function(client, bufnr)
--     require("lvim.lsp").common_on_attach(client, bufnr)
--     local _, _ = pcall(vim.lsp.codelens.refresh)
--     local map = function(mode, lhs, rhs, desc)
--       if desc then
--         desc = desc
--       end

--       vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
--     end
--     map("n", "<leader>Ci", "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies")
--     map("n", "<leader>Ct", "<cmd>GoMod tidy<cr>", "Tidy")
--     map("n", "<leader>Ca", "<cmd>GoTestAdd<Cr>", "Add Test")
--     map("n", "<leader>CA", "<cmd>GoTestsAll<Cr>", "Add All Tests")
--     map("n", "<leader>Ce", "<cmd>GoTestsExp<Cr>", "Add Exported Tests")
--     map("n", "<leader>Cg", "<cmd>GoGenerate<Cr>", "Go Generate")
--     map("n", "<leader>Cf", "<cmd>GoGenerate %<Cr>", "Go Generate File")
--     map("n", "<leader>Cc", "<cmd>GoCmt<Cr>", "Generate Comment")
--     map("n", "<leader>DT", "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test")
--   end,
--   on_init = require("lvim.lsp").common_on_init,
--   capabilities = require("lvim.lsp").common_capabilities(),
--   settings = {
--     gopls = {
--       usePlaceholders = true,
--       gofumpt = true,
--       codelenses = {
--         generate = false,
--         gc_details = true,
--         test = true,
--         tidy = true,
--       },
--     },
--   },
-- })

-- local status_ok, gopher = pcall(require, "gopher")
-- if not status_ok then
--   return
-- end

-- gopher.setup {
--   commands = {
--     go = "go",
--     gomodifytags = "gomodifytags",
--     gotests = "gotests",
--     impl = "impl",
--     iferr = "iferr",
--   },
-- }
