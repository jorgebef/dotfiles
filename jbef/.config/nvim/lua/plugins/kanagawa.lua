local M = {
  "rebelot/kanagawa.nvim",
}

function M.config()
  package.path = package.path .. ";/Users/jbef/.config/colors/?.lua"
  local kanagawa_custom = require("kanagawa-custom")

  require("kanagawa").setup({
    transparent = true, -- do not set background color

    colors = {
      palette = kanagawa_custom,
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
      -- local palette = colors.palette
      local palette = kanagawa_custom
      return {
        Cursor = { fg = theme.ui.bg, bg = theme.ui.fg },

        NormalFloat = { bg = theme.ui.bg },
        FloatBorder = { bg = theme.ui.bg },
        FloatTitle = { bg = theme.ui.bg },

        Pmenu = { bg = theme.ui.bg },
        PmenuSel = { fg = palette.springBlue, bg = palette.sumiInk5 },
        PmenuThumb = { bg = palette.sumiInk6 },

        NeoTreeFloatTitle = { fg = theme.ui.fg },
        NeoTreeTitleBar = { fg = theme.ui.bg, bg = palette.sumiInk6 },
        -- NeoTreeFloatBorder = { fg = theme.ui.fg },

        -- CmpItemMenu = { bg = palette.sumiInk3 },
        -- CmpItemKind = { bg = palette.sumiInk3 },
        -- CmpItemAbbr = { bg = palette.sumiInk3 },

        -- TelescopeNormal = { fg = colors.subtext0, bg = colors.bg },
        -- TelescopeBorder = { fg = palette.sumiInk6, bg = theme.ui.bg },
        -- TelescopeMatching = { fg = colors.pink, bg = nil, bold = true },
        -- TelescopeSelection = { fg = colors.text, bg = colors.surface0 },
        -- TelescopeSelectionCaret = { fg = colors.pink, bg = colors.surface0 },
        -- TelescopePreviewBorder = { fg = palette.sumiInk6, bg = theme.ui.bg },
        -- TelescopePreviewTitle = { fg = theme.ui.bg, bg = palette.sumiInk6, bold = true },
        -- TelescopePreviewNormal = { fg = colors.overlay2, bg = colors.bg },
        -- TelescopeResultsNormal = { fg = colors.overlay2, bg = colors.bg },
        -- TelescopeResultsTitle = { fg = theme.ui.bg, bg = palette.sumiInk6, bold = true },
        -- TelescopePromptBorder = { fg = palette.sumiInk6, bg = theme.ui.bg },
        -- TelescopePromptTitle = { fg = theme.ui.bg, bg = palette.sumiInk6, bold = true },
        -- TelescopePromptNormal = { fg = colors.overlay2, bg = colors.bg },
        -- TelescopePromptPrefix = { fg = colors.pink, bg = colors.bg },

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
        -- ["@tag.delimiter.tsx"] = { fg = palette.lotusGray3 },
        ["@tag.tsx"] = { fg = palette.crystalBlue },
        ["@tag.builtin.tsx"] = { fg = palette.sakuraPink },
        -- ["@tag.attribute.tsx"] = { fg = palette.lotusBlue3 },
      }
    end,
  })
end

return M
