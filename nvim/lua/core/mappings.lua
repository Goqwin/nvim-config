local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = ","

-- NvimTree Toggle
map("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

