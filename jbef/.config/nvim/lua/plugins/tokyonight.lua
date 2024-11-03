local M = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  enabled = false,
}

---@class tokyonight.Config
---@field on_colors fun(colors: ColorScheme)
---@field on_highlights fun(highlights: tokyonight.Highlights, colors: ColorScheme)
function M.config()
  require("tokyonight").setup({
    -- use the night style
    -- style = "night",
    -- style = "storm",
    transparent = true,
    -- disable italic for functions
    styles = {
      functions = {},
      sidebars = "transparent",
      floats = "transparent",
    },
    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors)
      -- colors.hint = colors.orange
      -- colors.error = "#ff0000"
    end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights tokyonight.Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,
  })
end

return M
