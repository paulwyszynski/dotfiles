-- TODO: Replace this with blink-cmp after obsidian.nvim support for blink-cmp is added
return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
        { name = "path" }, -- hrsh7th/cmp-path
        { name = "copilot" },
      }, {
        { name = "buffer" }, -- hrsh7th/cmp-buffer
      })
    end,
  },
}
