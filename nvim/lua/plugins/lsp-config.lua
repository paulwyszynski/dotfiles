return {
  -- MASON INSTALLER: LSPS, FORMATTERS, LINTERS --
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash-language-server",
        "bash-debug-adapter",
        "jsonlint",
        "json-lsp",
        "lemminx",
        "prettier",
        "shellcheck",
        "xmlformatter",
        "yaml-language-server",
        "yamllint",
        "yamlfix",
      })
    end,
  },
  -- LSPCONFIG --
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jsonls = {},
        lemminx = {},
        yamlls = {},
      },
    },
  },
  -- TREESITTER --
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add more
      vim.list_extend(opts.ensure_installed, {
        "json",
        "xml",
        "yaml",
      })
    end,
  },
  -- FORMATTERS --
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
        markdown = { "prettier" },
        xml = { "xmlformat" },
        yaml = { "yamlfix" },
      },
    },
  },
  -- LINTER
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        yaml = { "yamllint" },
      },
    },
  },
}
