return {
  -- "jorgebef/nordic.nvim",
  "AlexvZyl/nordic.nvim",
  -- branch = "dev",
  -- dev = true,
  lazy = false,
  enabled = false,
  priority = 1000,
  config = function()
    local U = require("nordic.utils")
    require("nordic").setup({
      visual = {
        theme = "light",
        blend = 0.95,
      },
      border_style = "flat",
      cursorline = {
        theme = "light",
        blend = 0.50,
      },

      on_palette = function(palette)
        U.merge_inplace(palette, {
          black0 = "#151723",
          black1 = "#191B29",
          -- Slightly darker than bg.  Very useful for certain popups
          black2 = "#212333",
          -- This color is used on their website's dark theme.
          gray0 = "#131523", --bg
          -- Polar Night.
          gray1 = "#2E3140",
          gray2 = "#3B3952",
          gray3 = "#43475E",
          gray4 = "#4C516A",
          -- A light blue/gray.
          gray5 = "#606A8A",
          white0_normal = "#BCC0D5",
          -- Snow storm.
          white1 = "#D7D7E8",
          white2 = "#E5E5F3",
          white3 = "#EFEFF8",
        })
      end,
      on_highlight = function(highlights, palette)
        -- highlights.Search.underline = false
        U.merge_inplace(highlights.Search, { underline = false, bold = false })
        U.merge_inplace(highlights.WinBar, { fg = palette.fg_dark, bg = palette.bg })
        U.merge_inplace(highlights.WinBarNC, { fg = palette.gray3, bg = palette.bg })
      end,
    })

    -- vim.cmd([[colorscheme nordic]])
  end,
}
