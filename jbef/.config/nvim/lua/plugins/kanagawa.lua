return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  enabled = false,
  priority = 1000,

  config = function()
    -- package.path = package.path .. ";/Users/jbef/.config/colors/?.lua"

    -- ---@type KanagawaCustom
    -- local kanagawaCustom = require("kanagawa-custom")

    require("kanagawa").setup({
      compile = false, -- enable compiling the colorscheme
      transparent = false, -- do not set background color

      colors = {

        palette = {
          -- -- change all usages of these colors
          springGreen = "#97b374",
          springBlue = "#86b1c2",
          crystalBlue = "#879fcf",
          oniViolet = "#9685b2",
          sakuraPink = "#ca869c",
          peachRed = "#ef6d71",
          carpYellow = "#dcc08e",
          surimiOrange = "#f0a475",
          -- fujiWhite = "#FFFFFF",
        },

        theme = {
          -- -- change specific usages for a certain theme, or for all of them
          -- wave = {
          --   ui = {
          --     float = {
          --       bg = "none",
          --     },
          --   },
          -- },
          -- dragon = {
          --   syn = {
          --     parameter = "yellow",
          --   },
          -- },
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },

      overrides = function(colors)
        local palette = colors.palette
        local theme = colors.theme

        return {

          -- -- -- NvimSurroundHighlight = { bg = theme.ui.fg },
          -- -- TelescopeBorder = { bg = "NONE" },
          -- -- TelescopeNormal = { fg = theme.ui.fg_dim },
          -- -- NoiceLspProgressSpinner = { fg = theme.ui.fg, bg = "NONE" },
          -- -- NoiceLspProgressTitle = { fg = theme.ui.fg, bg = "NONE" },
          -- -- NoiceLspProgressClient = { bg = "NONE" },
          -- -- FloatFooter = { bg = "NONE" },
          -- TelescopeNormal = { bg = theme.ui.bg },
          -- TelescopeBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg },
          -- TelescopePromptNormal = { bg = theme.ui.bg },
          -- TelescopePromptPrefix = { bg = theme.ui.bg },
          -- TelescopePromptCounter = { bg = theme.ui.bg },

          -- TelescopeBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg },

          NoiceFormatConfirm = { bg = theme.ui.bg },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p3 },

          -- PmenuSbar = { bg = theme.ui.bg_m1 },
          -- PmenuThumb = { bg = theme.ui.bg_p2 },

          -- DiagnosticUnnecessary = { fg = "NONE", undercurl = true, sp = theme.diag.info },

          -- NotifyBackground = { bg = theme.ui.bg },

          -- FloatBorder = { fg = theme.ui.shade0, bg = theme.ui.bg },

          -- WinSeparator = { fg = theme.ui.bg_p1 },
          WinSeparator = { fg = palette.sumiInk5 },

          -- ColorColumn = { bg = colors.palette.sumiInk1 },

          NavicText = { fg = theme.ui.fg_dim },

          WinbarFilenameActive = { fg = theme.ui.fg, bg = theme.ui.bg },
          WinbarActive = { fg = theme.ui.fg_dim, bg = theme.ui.bg },
          WinbarInactive = { fg = theme.syn.comment, bg = theme.ui.bg },

          MiniIndentscopeSymbol = { fg = palette.sumiInk6 },
          MiniIndentscopeSymbolOff = { fg = palette.sumiInk6 },
        }
      end,
    })
  end,
}
