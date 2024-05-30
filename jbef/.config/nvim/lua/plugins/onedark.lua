local M = {
  "navarasu/onedark.nvim",
}

function M.config()
  require("onedark").setup({
    style = "warmer", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'

    colors = {
      -- bright_orange = "#ff8800", -- define a new color
      -- green = "#00ffaa", -- redefine an existing color
    },
    highlights = {
      -- ["@keyword"] = { fg = "$green" },
      -- ["@string"] = { fg = "$bright_orange", bg = "#00ff00", fmt = "bold" },
      -- ["@function"] = { fg = "#0000ff", sp = "$cyan", fmt = "underline,italic" },
      -- ["@function.builtin"] = { fg = "#0059ff" },
    },
  })
end

return M
