local M = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
}

M.config = function()
  require("tokyonight").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day", -- The theme is used when the background is set to light
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "dark", -- style for sidebars, see below
      floats = "dark", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    -- day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

    -- --- You can override specific color groups to use other groups or a hex color
    -- --- function will be called with a ColorScheme table
    -- ---@param colors ColorScheme
    -- on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(hl, c)
      hl.WinSeparator = { fg = "#000000", bg = c.none }

      hl.CursorLineNr = { fg = c.orange }
      hl.Pmenu = { bg = c.bg_dark }
      -- hl.PmenuSel = { fg = c.magenta, bg = c.bg_highlight, bold = true }
      hl.NormalFloat = { bg = c.bg_dark }
      hl.FloatBorder = { fg = c.bg, bg = c.bg_dark }

      -- -- CmpBorder = { fg = c.bg_dark, bg = c.bg_dark }
      hl.CmpItemAbbrMatch = { fg = c.orange }
      hl.CmpItemAbbrMatchFuzzy = { fg = c.purple }
      hl.CmpItemMenu = { fg = c.fg_dark, bg = nil, italic = true }
      -- hl.CmpItemKindSnippet = { fg = c.bg, bg = c.purple }
      -- hl.CmpItemKindKeyword = { fg = c.bg, bg = c.red }
      -- hl.CmpItemKindText = { fg = c.bg, bg = c.teal }
      -- hl.CmpItemKindMethod = { fg = c.bg, bg = c.blue }
      -- hl.CmpItemKindConstructor = { fg = c.bg, bg = c.blue }
      -- hl.CmpItemKindFunction = { fg = c.bg, bg = c.blue }
      -- hl.CmpItemKindFolder = { fg = c.bg, bg = c.blue }
      -- hl.CmpItemKindModule = { fg = c.bg, bg = c.blue }
      -- hl.CmpItemKindConstant = { fg = c.bg, bg = c.orange }
      -- hl.CmpItemKindField = { fg = c.bg, bg = c.green }
      -- hl.CmpItemKindProperty = { fg = c.bg, bg = c.green }
      -- hl.CmpItemKindEnum = { fg = c.bg, bg = c.green }
      -- hl.CmpItemKindUnit = { fg = c.bg, bg = c.green }
      -- hl.CmpItemKindClass = { fg = c.bg, bg = c.yellow }
      -- hl.CmpItemKindVariable = { fg = c.bg, bg = c.red1 }
      -- hl.CmpItemKindFile = { fg = c.bg, bg = c.blue }
      -- hl.CmpItemKindInterface = { fg = c.bg, bg = c.yellow }
      -- hl.CmpItemKindColor = { fg = c.bg, bg = c.red }
      -- hl.CmpItemKindReference = { fg = c.bg, bg = c.red }
      -- hl.CmpItemKindEnumMember = { fg = c.bg, bg = c.red }
      -- hl.CmpItemKindStruct = { fg = c.bg, bg = c.blue }
      -- hl.CmpItemKindValue = { fg = c.bg, bg = c.peach }
      -- hl.CmpItemKindEvent = { fg = c.bg, bg = c.blue }
      -- hl.CmpItemKindOperator = { fg = c.bg, bg = c.blue }
      -- hl.CmpItemKindTypeParameter = { fg = c.bg, bg = c.blue }
      -- hl.CmpItemKindCopilot = { fg = c.bg, bg = c.teal }

      hl.TelescopeNormal = { fg = c.fg_dark, bg = c.bg_dark }
      hl.TelescopeBorder = { fg = c.bg, bg = c.bg_dark }
      hl.TelescopeMatching = { fg = c.orange, bg = nil }
      hl.TelescopeSelection = { fg = c.fg, bg = c.bg_highlight }
      -- hl.TelescopeSelectionCaret = { fg = c.magenta, bg = c.bg_dark }
      -- hl.TelescopePreviewBorder = { fg = c.bg_dark, bg = c.bg }
      -- hl.TelescopePreviewTitle = { fg = c.bg_dark, bg = c.bg }
      -- hl.TelescopePreviewNormal = { fg = c.overlay0, bg = c.bg }
      -- hl.TelescopeResultsNormal = { fg = c.overlay2, bg = "#272738" }
      -- -- TelescopeResultsBorder = { fg = c.bg_dark, bg = c.bg }
      -- hl.TelescopePromptNormal = { fg = c.overlay2, bg = "#272738" }
      -- hl.TelescopePromptPrefix = { fg = c.magenta, bg = c.bg_dark }

      -- hl.FzfLuaNormal = { fg = c.overlay2, bg = nil }
      -- hl.FzfLuaBorder = { fg = c.bg_highlight, bg = nil }
      -- hl.FzfLuaSearch = { fg = c.magenta, bg = nil }
      -- hl.FzfLuaMatching = { fg = c.magenta, bg = nil, bold = true }
      -- hl.FzfLuaPromptPrefix = { fg = c.magenta, bg = nil, bold = true }
      -- hl.FzfLuaTitle = { fg = c.magenta, bg = nil, bold = true }
      -- hl.FzfLuaCursor = { fg = c.red, bg = c.overlay2 }
      -- hl.FzfLuaCursorLine = { fg = c.fg, bg = c.overlay2 }
      -- hl.FzfLuaPrompt = { fg = c.blue, bg = c.overlay2 }
      -- hl.FzfLuaSelection = { fg = c.fg, bg = "#3B3D4F" }
      -- hl.FzfLuaSelectionCaret = { fg = c.magenta, bg = c.bg }
      -- hl.FzfLuaPreviewBorder = { fg = c.bg_dark, bg = c.bg }
      -- hl.FzfLuaPreviewTitle = { fg = c.bg_dark, bg = c.bg }
      -- hl.FzfLuaPreviewNormal = { fg = c.overlay0, bg = c.bg }
      -- hl.FzfLuaResultsNormal = { fg = c.overlay2, bg = nil }
      -- -- TelescopeResultsBorder = { fg = c.bg_dark, bg = c.bg }
      -- hl.FzfLuaPromptNormal = { fg = c.overlay2, bg = c.bg }

      hl.IndentBlanklineContextChar = { fg = c.fg, bg = c.none }
      hl.IndentBlanklineChar = { fg = c.fg_gutter, bg = c.none }

      hl.WinBar = { fg = c.fg_dark, bg = nil }
      hl.WinBarInactive = { fg = c.fg_gutter, bg = nil }
      hl.WinBarFilenameActive = { fg = c.bg, bg = c.purple, bold = true }
      hl.WinBarFilenameInactive = { fg = c.fg_dark, bg = nil, bold = true }
      -- hl.WhichKeyFloat = { bg = c.bg_dark }
      -- hl.WhichKeyBorder = { fg = c.blue, bg = c.bg_dark }

      -- LSP Specific
      -- ===============
      -- hl.DiagnosticUnnecessary = { sp = c.teal, underline = true }
      -- Language specific
      -- ===============
      -- hl["@tag.tsx"] = { fg = c.magenta }
    end,
  })
end

return M
