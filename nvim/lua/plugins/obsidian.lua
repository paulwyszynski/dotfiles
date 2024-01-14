return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    workspaces = {
      {
        name = "Paulaner",
        path = "~/Dev/Git/obsidian/Paulaner",
      },
    },
  },
}
