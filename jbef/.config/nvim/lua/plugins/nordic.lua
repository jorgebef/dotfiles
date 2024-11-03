local M = {
  "AlexvZyl/nordic.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
  },
}

function M.config()
  require("nordic").setup({
    -- This callback can be used to override the colors used in the base palette.
    on_palette = function(palette) end,
    -- This callback can be used to override the colors used in the extended palette.
    after_palette = function(palette) end,
    -- This callback can be used to override highlights before they are applied.
    on_highlight = function(highlights, palette)
      -- Custom Highlights over default
      highlights.CursorLine = { fg = nil, bg = palette.gray1 }
      highlights.IblScope = { fg = palette.gray4 }
      highlights.IblIndent = { fg = palette.gray1 }
      highlights.FloatBorder = { fg = palette.gray0, bg = palette.black1 }
      -- Winbar
      highlights.WinBarInactive = { fg = palette.gray2, bg = nil }
      highlights.WinBarFilenameActive = { fg = palette.white0, bg = nil, bold = false }
      highlights.WinBarFilenameInactive = { fg = palette.gray1, bg = nil, bold = false }
      -- Blink.cmp
      highlights.BlinkCmpMenuBorder = { fg = palette.gray0, bg = palette.black1 }
      highlights.BlinkCmpMenuSelection = { fg = nil, bg = palette.gray1 }
      highlights.BlinkCmpLabelMatch = { fg = nil, bg = palette.gray1 }
      -- LSP specific
      highlights["@punctuation.bracket"] = { fg = palette.gray5 }
    end,
    -- Enable bold keywords.
    bold_keywords = false,
    -- Enable italic comments.
    italic_comments = true,
    -- Enable editor background transparency.
    transparent = {
      -- Enable transparent background.
      bg = true,
      -- Enable transparent background for floating windows.
      float = false,
    },
    -- Enable brighter float border.
    bright_border = false,
    -- Reduce the overall amount of blue in the theme (diverges from base Nord).
    reduced_blue = true,
    -- Swap the dark background with the normal one.
    swap_backgrounds = false,
    -- Cursorline options.  Also includes visual/selection.
    cursorline = {
      -- Bold font in cursorline.
      bold = false,
      -- Bold cursorline number.
      bold_number = true,
      -- Available styles: 'dark', 'light'.
      theme = "light",
      -- Blending the cursorline bg with the buffer bg.
      blend = 0.95,
    },
    noice = {
      -- Available styles: `classic`, `flat`.
      style = "classic",
    },
    telescope = {
      -- Available styles: `classic`, `flat`.
      style = "flat",
    },
    leap = {
      -- Dims the backdrop when using leap.
      dim_backdrop = false,
    },
    ts_context = {
      -- Enables dark background for treesitter-context window
      dark_background = true,
    },
  })

  vim.cmd([[colorscheme nordic]])
end

return M
