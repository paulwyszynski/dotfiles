return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources({
        { name = "luasnip" }, -- For luasnip users.
        { name = "nvim_lsp" },
        { name = "path" }, -- hrsh7th/cmp-path
        -- { name = "ultisnips" }, -- For ultisnips users.
        -- { name = "vsnip" }, -- For vsnip users.
        -- { name = "snippy" }, -- For snippy users.
      }, {
        { name = "buffer" }, -- hrsh7th/cmp-buffer
      })
    end,
  },
}
