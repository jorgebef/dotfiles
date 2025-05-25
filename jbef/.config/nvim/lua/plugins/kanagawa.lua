return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  enabled = true,
  priority = 1000,

  config = function()
    require("kanagawa").setup({
      compile = false, -- enable compiling the colorscheme
      transparent = false,
      keywordStyle = { bold = false },

      colors = {

        palette = {
          dragonWhite = "#DCD7C3", --INFO: CUSTOM
        },

        theme = {
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
          -- NoiceFormatConfirm = { bg = theme.ui.bg },

          Pmenu = { fg = theme.ui.fg, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.pmenu.bg_sel },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          BlinkCmpMenuBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_p1 },
          BlinkCmpDoc = { fg = nil, bg = theme.ui.bg_p1 },
          BlinkCmpDocBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_p1 },
          BlinkCmpDocSeparator = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },

          -- DiagnosticUnnecessary = { fg = "NONE", undercurl = true, sp = theme.diag.info },

          -- NotifyBackground = { bg = theme.ui.bg },

          NormalFloat = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
          FloatBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_p1 },

          -- WinSeparator = { fg = theme.ui.bg_p1 },
          WinSeparator = { fg = palette.sumiInk5 },

          -- ColorColumn = { bg = colors.palette.sumiInk1 },

          -- NavicText = { fg = theme.ui.fg_dim },

          -- WinbarFilenameActive = { fg = theme.ui.fg, bg = theme.ui.bg },
          WinBar = { fg = theme.ui.fg, bg = theme.ui.bg },
          WinBarNC = { fg = theme.syn.comment, bg = theme.ui.bg },

          MiniIndentscopeSymbol = { fg = palette.sumiInk6 },
          MiniIndentscopeSymbolOff = { fg = palette.sumiInk6 },
        }
      end,
    })

    vim.cmd([[colorscheme kanagawa-dragon]])
  end,
}
