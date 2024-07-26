-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local api = vim.api
local keymap = vim.keymap
local wk = require("which-key")

local function add_diff_merge_keymaps()
  --INFO: List buffers is useful for diffget. You have to name the buffer to get the changes from e.g. diffget 1 (take local changes).
  keymap.set("n", "<leader>gds", "<cmd>ls<cr>", { desc = "List Buffers" })
  keymap.set("n", "<leader>gdl", "<cmd>diffget 1<cr>", { desc = "Take Local Change" })
  keymap.set("n", "<leader>gdr", "<cmd>diffget 2<cr>", { desc = "Take Remote Change" })
  wk.add({
    { "<leader>gd", group = "Diff", mode = "n" }, --INFO: Add description for this group inside Git group.
    { "[c", desc = "Previous Conflict" }, --INFO: Added from nvim documentation.
    { "]c", desc = "Next Conflict" }, --INFO: Added from nvim documentation.
  })
end

-- INFO: When nvim is opened with a diff, only then are the keymaps applied.
api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.o.diff then
      add_diff_merge_keymaps()
    end
  end,
})
