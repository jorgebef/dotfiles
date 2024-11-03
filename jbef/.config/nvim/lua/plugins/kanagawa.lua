local M = {
  "rebelot/kanagawa.nvim",
  lazy = false,
  enabled = false,
  priority = 1000,
}

function M.config()
  package.path = package.path .. ";/Users/jbef/.config/colors/?.lua"

  ---@type KanagawaCustom
  local kanagawaCustom = require("kanagawa-custom")

  require("kanagawa").setup({
    compile = false, -- enable compiling the colorscheme
    transparent = true, -- do not set background color

    colors = {
      palette = kanagawaCustom.palette,
      theme = {
        all = kanagawaCustom.wave,
      },
    },

    overrides = function(colors)
      -- ---@type KanagawaCustomPalette
      -- local palette = colors.palette

      ---@type KanagawaCustomTheme
      local theme = colors.theme

      return {

        -- NvimSurroundHighlight = { bg = theme.ui.fg },
        TelescopeBorder = { bg = "NONE" },
        TelescopeNormal = { fg = theme.ui.fg_dim },
        NoiceLspProgressSpinner = { fg = theme.ui.fg, bg = "NONE" },
        NoiceLspProgressTitle = { fg = theme.ui.fg, bg = "NONE" },
        NoiceLspProgressClient = { bg = "NONE" },
        FloatFooter = { bg = "NONE" },

        DiagnosticUnnecessary = { fg = "NONE", undercurl = true, sp = theme.diag.info },

        NotifyBackground = { bg = theme.ui.bg },

        NavicText = { fg = theme.ui.fg_dim },

        WinbarFilenameActive = { fg = theme.ui.fg, bg = theme.ui.bg },
        WinbarActive = { fg = theme.ui.fg_dim, bg = theme.ui.bg },
        WinbarInactive = { fg = theme.syn.comment, bg = theme.ui.bg },
      }
    end,
  })

  -- vim.cmd([[colorscheme kanagawa]])
end

return M
