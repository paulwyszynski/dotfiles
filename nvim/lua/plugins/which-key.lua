return {
  "folke/which-key.nvim",
  opts = {
    defaults = {
      [";"] = { desc = "Repeat f, t, F or T N times" },
      [","] = { desc = "Repeat f, t, F or T N times backwards" },
      ["<C-t>"] = { desc = "Indent in insert mode" },
      ["<C-d>"] = { desc = "Unindent in insert mode" },
    },
  },
}
