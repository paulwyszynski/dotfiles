return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Go to left window" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Go to down window" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Go to up window" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Go to right window" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Go to previous window" },
  },
}
