local opts = { noremap = true, silent = true }

-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.api.nvim_set_keymap
---------------------
-- General Keymaps
---------------------

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("v", "p", '"_dP', opts)

-- clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>", opts)

-- delete single character without copying into register
keymap("n", "x", '"_x', opts)

-- increment/decrement numbers
keymap("n", "<leader>+", "<C-a>", opts) -- increment
keymap("n", "<leader>-", "<C-x>", opts) -- decrement

-- window management
keymap("n", "<leader>sv", "<C-w>v", opts) -- split window vertically
keymap("n", "<leader>sh", "<C-w>s", opts) -- split window horizontally
keymap("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
keymap("n", "<leader>sx", ":close<CR>", opts) -- close current split window

keymap("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
keymap("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
keymap("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
keymap("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Visual Block Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

----------------------
-- Plugin Keybinds
----------------------
-- vim-maximizer
keymap("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- toggle split window maximization

-- restart lsp server (not on youtube nvim video, opts)
keymap("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

-- Comment
keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)
