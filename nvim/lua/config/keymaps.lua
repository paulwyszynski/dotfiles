-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps her

local keymap = vim.keymap

-- Change navigation on Mac
keymap.set("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
keymap.set(
  "n",
  "<leader>svt",
  "<cmd>lua require('telescope.builtin').live_grep({ hidden = false, search_dirs = { '~/Dev/Git/obsidian/Paulaner/'} })<cr>",
  { desc = "Search Vault for Text" }
)
keymap.set(
  "n",
  "<leader>svf",
  "<cmd>lua require('telescope.builtin').find_files({ hidden = false, search_dirs = { '~/Dev/Git/obsidian/Paulaner/' } })<cr>",
  { desc = "Search Vault for Files" }
)

-- INFO: Not used anymore, since caps lock is remapped to escape

-- Better escape
-- keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })
-- Leads to slow scrolling down inside lazygit
-- keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })
