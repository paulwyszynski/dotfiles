-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps her

local keymap = vim.keymap
local obsidian_vault_path = os.getenv("OBSIDIAN_VAULT")

-- Change navigation on Mac
keymap.set("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
keymap.set("n", "<leader>svt", function()
  Snacks.picker.grep({ cwd = obsidian_vault_path })
end, { desc = "Search Vault for Text" })
keymap.set("n", "<leader>svf", function()
  Snacks.picker.files({ cwd = obsidian_vault_path })
end, { desc = "Search Vault for Files" })

-- INFO: Not used anymore, since caps lock is remapped to escape

-- Better escape
-- keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })
-- Leads to slow scrolling down inside lazygit
-- keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })
