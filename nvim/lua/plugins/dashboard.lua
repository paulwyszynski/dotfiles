return {
  "nvimdev/dashboard-nvim",
  opts = function(_, opts)
    local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███    ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

paul_wyszynski
]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"
    opts.config.header = vim.split(logo, "\n")
    opts.config.center[4].key = "t" -- change key binding for menu

    table.insert(opts.config.center, 9, {
      icon = "  ",
      desc = "Find Text in Vault",
      action = "Telescope live_grep cwd=~/Dev/Git/obsidian/Paulaner hidden=false",
      key = "1",
      key_format = "  %s",
    })

    table.insert(opts.config.center, 10, {
      icon = "  ",
      desc = "Find File in Vault",
      action = "Telescope find_files cwd=~/Dev/Git/obsidian/Paulaner hidden=false",
      key = "2",
      key_format = "  %s",
    })
  end,
}
