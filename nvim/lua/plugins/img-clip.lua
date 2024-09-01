if true then
  return {}
end
-- return {
--   "HakonHarnes/img-clip.nvim",
--   event = "VeryLazy",
--   opts = {
--     default = {
--       extension = "avif",
--       process_cmd = "magick - -quality 75 -",
--       dir_path = function()
--         return vim.fn.expand("%:t:r") .. "_img"
--       end,
--       prompt_for_file_name = true,
--       drag_and_drop = {
--         enable = true,
--         insert_mode = true,
--       },
--     },
--   },
--   keys = {
--     { "<leader>v", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
--   },
-- }
