-- package.path = package.path .. "~/.config/colors"
-- local palette = require("jbef.config.colors.kanagawa-custom")

local M = {

  colors = {
    foreground = "#DCDFDF",
    -- foreground = palette.fujiWhite,
    background = "#1f1f28",
    -- background = palette.sumiInk3,

    cursor_bg = "#D1D3D3",
    cursor_fg = "#16161D",
    cursor_border = "#c8c093",

    selection_fg = "#c8c093",
    selection_bg = "#2d4f67",

    scrollbar_thumb = "#16161d",
    split = "#16161d",

    ansi = { "#090618", "#EF6D71", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
    brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
    indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
  },
}

return M
