return {
  "folke/snacks.nvim",
  opts = {
    styles = {
      terminal = {
        position = "float",
        border = "rounded",
        width = 0.75,
        height = 0.75,
      },
    },
    picker = {
      sources = {
        explorer = {
          layout = {
            -- float the preview over the main editor window instead of inside the sidebar.
            -- `hidden` starts it closed; `P` (explorer list key) toggles it.
            -- both override the source default `preview = false`, which snacks rewrites into
            -- `hidden` but which also wipes the "main" flag from the sidebar preset.
            -- keep the `preview` box entry below: the layout only shows wins listed in the box.
            preview = "main",
            hidden = { "preview" },
            layout = {
              backdrop = false,
              width = 40,
              min_width = 40,
              height = 0,
              position = "left",
              border = "none",
              box = "vertical",
              {
                win = "input",
                height = 1,
                border = "rounded",
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", border = "rounded" },
              { win = "preview", title = "{preview}", height = 0.5, border = "rounded" },
            },
          },
        },
      },
    },
    -- INFO:Some nvim features will be disabled if the file exceeds the defined file size and line length
    bigfile = {
      size = 100 * 1024 * 1024, -- 10MB
      line_length = 10000,
    },
    image = {
      doc = {
        enabled = true,
        inline = false,
        max_width = 50,
        max_height = 50,
      },
    },
  },
}
