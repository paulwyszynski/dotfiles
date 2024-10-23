-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.conceallevel = 1 -- Used for obsidian.nvim
opt.textwidth = 140 -- Word wrap at 80 characters
opt.colorcolumn = "140" -- Highlight column 80
opt.spelllang = { "en", "de" }
