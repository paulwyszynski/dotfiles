return {
  "folke/snacks.nvim",
  opts = {
    -- INFO:Some nvim features will be disabled if the file exceeds the defined file size and line length
    bigfile = {
      size = 100 * 1024 * 1024, -- 10MB
      line_length = 10000,
    },
  },
}
