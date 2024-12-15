return {
  -- NOTE: MASON INSTALLER: LSPS, FORMATTERS, LINTERS AND DEBUGGERS
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash-language-server",
        "bash-debug-adapter",
        "css-lsp",
        "html-lsp",
        "jsonlint",
        "json-lsp",
        "markuplint",
        "lemminx",
        "prettier",
        "shellcheck",
        "stylelint",
        "stylelint-lsp",
        "xmlformatter",
        "yaml-language-server",
        "yamllint",
        "yamlfix",
      })
    end,
  },
  -- NOTE: LSPCONFIG
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "zsh" },
        },
        html = {},
        jsonls = {},
        lemminx = {},
        cssls = {
          filetypes = { "css", "scss", "less" },
        },
        yamlls = {},
      },
    },
  },
  -- NOTE: TREESITTER
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add more
      vim.list_extend(opts.ensure_installed, {
        "css",
        "xml",
      })
    end,
  },
  -- NOTE: FORMATTERS
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        xml = { "xmlformat" },
        yaml = { "yamlfix" },
      },
    },
  },
  -- NOTE: LINTER
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        css = { "stylelint" },
        html = { "markuplint" },
        yaml = { "yamllint" },
      },
    },
  },
}
