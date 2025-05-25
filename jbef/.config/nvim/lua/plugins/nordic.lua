local M = {
  "AlexvZyl/nordic.nvim",
  -- "jorgebef/nordic.nvim",
  lazy = false,
  priority = 1000,
  enabled = false,
  -- dir = "~/Developer/nordic.nvim/",
  -- dev = true,
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
    -- -- Enable bold keywords.
    -- bold_keywords = false,
    -- -- Enable italic comments.
    -- italic_comments = true,
    -- -- Enable editor background transparency.
    -- transparent = {
    --   -- Enable transparent background.
    --   bg = false,
    --   -- Enable transparent background for floating windows.
    --   float = false,
    -- },
    -- -- Enable brighter float border.
    border_style = "flat",
    -- -- Reduce the overall amount of blue in the theme (diverges from base Nord).
    -- reduced_blue = true,
    -- -- Swap the dark background with the normal one.
    -- swap_backgrounds = false,
    -- Cursorline options.  Also includes visual/selection.
    cursorline = {
      -- Bold font in cursorline.
      bold = false,
      -- Bold cursorline number.
      bold_number = true,
      -- Available styles: 'dark', 'light'.
      theme = "light",
      -- Blending the cursorline bg with the buffer bg.
      blend = 0.5,
    },
    visual = {
      -- Available styles: 'dark', 'light'.
      theme = "light",
      -- Blending the cursorline bg with the buffer bg.
      blend = 0.75,
    },
    -- noice = {
    --   -- Available styles: `classic`, `flat`.
    --   style = "classic",
    -- },
    -- telescope = {
    --   -- Available styles: `classic`, `flat`.
    --   style = "flat",
    -- },
    -- leap = {
    --   -- Dims the backdrop when using leap.
    --   dim_backdrop = false,
    -- },
    -- ts_context = {
    --   -- Enables dark background for treesitter-context window
    --   dark_background = true,
    -- },

    on_highlight = function(highlights, p)
      -- Winbar
      highlights.WinBarNC = { fg = p.gray4, bg = nil }
      highlights.WinBar = { fg = p.white0, bg = nil, bold = false }
      -- highlights.WinSeparator = { fg = p.gray2, bg = nil, bold = false }
      highlights.Folded = { fg = p.gray5, bg = p.black1 }
      highlights.SnacksPickerlistCursorLine = { bg = p.bg_cursorline }
      -- -- Blink.cmp
      -- highlights.BlinkCmpMenuBorder = { fg = palette.gray0, bg = palette.black1 }
      -- highlights.BlinkCmpMenuSelection = { fg = nil, bg = palette.gray1 }
      -- highlights.BlinkCmpLabelMatch = { fg = nil, bg = palette.gray1 }
      -- LSP specific
      highlights["@punctuation.bracket"] = { fg = p.gray5 }
    end,
  })

  vim.cmd([[colorscheme nordic]])
end

return M
