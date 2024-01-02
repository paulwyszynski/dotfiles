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
  end,
}
