local M = {
  "rebelot/kanagawa.nvim",
  lazy = false,
  enabled = true,
  priority = 1000,
}

function M.config()
  -- package.path = package.path .. ";/Users/jbef/.config/colors/?.lua"

  -- ---@type KanagawaCustom
  -- local kanagawaCustom = require("kanagawa-custom")

  require("kanagawa").setup({
    compile = false, -- enable compiling the colorscheme
    transparent = true, -- do not set background color

    colors = {
      palette = {
        -- -- change all usages of these colors
        -- sumiInk0 = "#000000",
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

        -- -- NvimSurroundHighlight = { bg = theme.ui.fg },
        -- TelescopeBorder = { bg = "NONE" },
        -- TelescopeNormal = { fg = theme.ui.fg_dim },
        -- NoiceLspProgressSpinner = { fg = theme.ui.fg, bg = "NONE" },
        -- NoiceLspProgressTitle = { fg = theme.ui.fg, bg = "NONE" },
        -- NoiceLspProgressClient = { bg = "NONE" },
        -- FloatFooter = { bg = "NONE" },
        TelescopeNormal = { bg = theme.ui.bg },
        TelescopeBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg },
        TelescopePromptNormal = { bg = theme.ui.bg },
        TelescopePromptPrefix = { bg = theme.ui.bg },
        TelescopePromptCounter = { bg = theme.ui.bg },

        -- TelescopeBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg },

        NoiceFormatConfirm = { bg = theme.ui.bg },

        -- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
        -- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },

        -- PmenuSbar = { bg = theme.ui.bg_m1 },
        -- PmenuThumb = { bg = theme.ui.bg_p2 },

        -- DiagnosticUnnecessary = { fg = "NONE", undercurl = true, sp = theme.diag.info },

        -- NotifyBackground = { bg = theme.ui.bg },

        FloatBorder = { fg = theme.ui.bg, bg = palette.dragonBlack0 },

        WinSeparator = { fg = theme.ui.bg_m3 },

        ColorColumn = { bg = colors.palette.sumiInk1 },

        NavicText = { fg = theme.ui.fg_dim },

        WinbarFilenameActive = { fg = theme.ui.fg, bg = theme.ui.bg },
        WinbarActive = { fg = theme.ui.fg_dim, bg = theme.ui.bg },
        WinbarInactive = { fg = theme.syn.comment, bg = theme.ui.bg },

        MiniIndentscopeSymbol = { fg = palette.sumiInk6 },
        MiniIndentscopeSymbolOff = { fg = palette.sumiInk6 },
      }
    end,
  })
end

return M
