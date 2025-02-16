return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  ft = "dart",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = true,
  opts = {
    flutter_path = "/opt/homebrew/bin/flutter",
    debugger = {
      enabled = false,
    },
    lsp = {
      on_attach = function(client, bufnr)
        if client.name == "dartls" then
          vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<leader>co",
            "<cmd>Telescope flutter commands<CR>",
            { desc = "Flutter" }
          )
          vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<leader>cs",
            "<cmd>FlutterOutlineToggle<CR>",
            { desc = "Toogle Outline" }
          )
        end
      end,
      dev_log = {
        enabled = true,
        focus_on_open = false,
        open_cmd = "10split",
      },
      outline = {
        open_cmd = "20vnew",
      },
      color = {
        enabled = true,
        background = true,
        foreground = true,
        virtual_text = true,
      },
    },
  },
}
