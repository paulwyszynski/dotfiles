return {
  {
    "3rd/image.nvim",
    opts = {
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = true,
          only_render_image_at_cursor = true,
          only_render_image_at_cursor_mode = "inline",
        },
      },
      html = {
        enabled = true,
      },
      css = {
        enabled = true,
      },
      max_width_window_percentage = 50,
      tmux_show_only_in_active_window = true,
    },
  },
}
