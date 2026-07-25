return {
  -- NOTE: MASON INSTALLER: LSPS, FORMATTERS, LINTERS AND DEBUGGERS
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash-language-server",
        "bash-debug-adapter",
        "css-lsp",
        -- "dart-debug-adapter", -> Handled by flutter-tools.nvim
        "gradle-language-server",
        "html-lsp",
        "jsonlint",
        "json-lsp",
        "markuplint",
        "lemminx",
        "prettier",
        "shellcheck",
        "stylelint",
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
        gradle_ls = {},
        --   root_dir = function(fname)
        --     return require("lspconfig.util").root_pattern("settings.gradle", "build.gradle")(fname)
        --   end,
        --   init_options = {
        --     settings = {
        --       gradleWrapperEnabled = true,
        --     },
        --   },
        -- },
        html = {},
        -- jsonls = {},
        lemminx = {},
        cssls = {},
        -- yamlls = {},
        -- dartls = {}, -> Handled by flutter-tools.nvim
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
        -- Runs after prettier: re-collapses the blank line prettier/other
        -- tools may leave between a table and a directly-following
        -- <!-- TBLFM: ... --> comment (Advanced Tables formula line must
        -- stay immediately below the table it belongs to).
        markdown = { "prettier", "fix_tblfm_spacing" },
        xml = { "xmlformat" },
        yaml = { "yamlfix" },
      },
      formatters = {
        fix_tblfm_spacing = {
          -- Pure-Lua formatter, no external command needed.
          format = function(self, ctx, lines, callback)
            local text = table.concat(lines, "\n")
            local fixed = text:gsub("\n\n(<!%-%-%s*TBLFM:.-%-%->)", "\n%1")
            callback(nil, vim.split(fixed, "\n"))
          end,
        },
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
