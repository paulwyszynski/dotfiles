return {
  "folke/which-key.nvim",
  opts = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>sv", desc = "+vault" },
    })
  end,
}
