return {
  "MeanderingProgrammer/render-markdown.nvim",
  main = "render-markdown",
  opts = {
    heading = {
      -- Turn on / off heading icon & background rendering
      enabled = true,
      -- Turn on / off any sign column related rendering
      sign = true,
      -- Replaces '#+' of 'atx_h._marker'
      -- The number of '#' in the heading determines the 'level'
      -- The 'level' is used to index into the array using a cycle
      -- The result is left padded with spaces to hide any additional '#'
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      -- Added to the sign column if enabled
      -- The 'level' is used to index into the array using a cycle
      signs = { "󰫎 " },
      -- The 'level' is used to index into the array using a clamp
      -- Highlight for the heading icon and extends through the entire line
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      -- The 'level' is used to index into the array using a clamp
      -- Highlight for the heading and sign icons
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },
    html = {
      comment = {
        -- Turn on / off HTML comment concealing
        conceal = false,
      },
    },
    link = {
      custom = {
        neovim = {
          pattern = "neovim[%w%p]*.io",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        wikipedia = {
          pattern = "wikipedia[%w%p]*.org",
          icon = "󰖬 ",
          highlight = "RenderMarkdownLink",
        },
        stackoverflow = {
          pattern = "stackoverflow[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        stackexchange = {
          pattern = "stackexchange[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        reddit = {
          pattern = "reddit[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        github = {
          pattern = "github[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        google_us = {
          pattern = "google[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        google_de = {
          pattern = "google[%w%p]*.de",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        youtube = {
          pattern = "youtube[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        facebook = {
          pattern = "facebook[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        twitter = {
          pattern = "twitter[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        x = {
          pattern = "x[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        instagram = {
          pattern = "instagram[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        amazon_us = {
          pattern = "amazon[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        amazon_uk = {
          pattern = "amazon[%w%p]*.co.uk",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        amazon_de = {
          pattern = "amazon[%w%p]*.de",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        amazon_eu_short_url = {
          pattern = "amzn[%w%p]*.eu",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        android = {
          pattern = "android[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        apple = {
          pattern = "apple[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        kotlin = {
          pattern = "kotlinlang[%w%p]*.org",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        swift = {
          pattern = "swift[%w%p]*.org",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        material = {
          pattern = "material[%w%p]*.io",
          icon = "󰦆 ",
          highlight = "RenderMarkdownLink",
        },
        gnu = {
          pattern = "gnu[%w%p]*.org",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        medium = {
          pattern = "medium[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        linkedin = {
          pattern = "linkedin[%w%p]*.com",
          icon = "󰌻 ",
          highlight = "RenderMarkdownLink",
        },
        xing = {
          pattern = "xing[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        tmuxcheatsheet = {
          pattern = "tmuxcheatsheet[%w%p]*.com",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
        openbsd = {
          pattern = "man.openbsd[%w%p]*.org",
          icon = " ",
          highlight = "RenderMarkdownLink",
        },
      },
    },
  },
  -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
}
