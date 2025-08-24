return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    transparent_background = true,
    styles = {
      keywords = { "italic" },
    },
    -- TODO: Remove this setup fucntion when Lazyvim is updated: https://github.com/LazyVim/LazyVim/issues/6355
    setup = function()
      local module = require("catppuccin.groups.integrations.bufferline")
      if module then
        module.get = module.get_theme
      end
    end,
  },
}
