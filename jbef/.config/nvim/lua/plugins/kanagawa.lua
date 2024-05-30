local M = {
  "rebelot/kanagawa.nvim",
}

function M.config()
  require("kanagawa").setup({

    colors = {
      palette = {
        fujiWhite = "#D1D3D3",
        -- waveRed = "#DF4A4F",
      },
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },

    overrides = function(colors)
      local theme = colors.theme
      local palette = colors.palette
      return {
        Cursor = { fg = theme.ui.bg, bg = theme.ui.fg },

        NormalFloat = { bg = theme.ui.bg },
        FloatBorder = { bg = theme.ui.bg },
        FloatTitle = { bg = theme.ui.bg },

        -- -- Save an hlgroup with dark background and dimmed foreground
        -- -- so that you can use it where your still want darker windows.
        -- -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
        -- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

        -- -- Popular plugins that open floats will link to NormalFloat by default;
        -- -- set their background accordingly if you wish to keep them dark and borderless
        -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

        StatusLine = { bg = palette.waveRed },
        StatusLineNC = { bg = palette.waveRed },

        -- IblScope = { fg = palette.fujiWhite, bg = "none" },
        IblIndent = { fg = palette.sumiInk5, bg = "none" },

        -- ["@comment"] = { fg = palette.sumiInk6 },
      }
    end,
  })
end

return M
