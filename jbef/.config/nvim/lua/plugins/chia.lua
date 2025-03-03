local M = {
  "jorgebef/chia.nvim",
  lazy = false,
  priority = 1000,
  enabled = false,
  dir = "~/Developer/chia.nvim/",
  dev = true,
}

function M.config()
  require("chia").setup({
    undercurl = true,
    transparent = false,
    gutter = false,
    dimInactive = false, -- disabled when transparent
    terminalColors = true,
    commentStyle = { italic = true },
    functionStyle = { italic = false },
    keywordStyle = { italic = false, bold = false },
    statementStyle = { italic = false, bold = false },
    typeStyle = { italic = false },
    -- integrations = {
    --   ["navic"] = true,
    --   ["nvim-cmp"] = true,
    --   ["gitsigns"] = true,
    --   ["gitgutter"] = true,
    --   ["telescope"] = true,
    --   ["nvim-tree"] = true,
    --   ["neotree"] = true,
    -- },

    -- colors = {
    --   palette = {
    --     -- -- change all usages of these colors
    --     -- sumiInk0 = "#000000",
    --     -- fujiWhite = "#FFFFFF",
    --   },
    --   theme = {
    --     -- -- change specific usages for a certain theme, or for all of them
    --     -- wave = {
    --     --   ui = {
    --     --     float = {
    --     --       bg = "none",
    --     --     },
    --     --   },
    --     -- },
    --     -- dragon = {
    --     --   syn = {
    --     --     parameter = "yellow",
    --     --   },
    --     -- },
    --     ui = {
    --       bg_gutter = "none",
    --     },
    --   },
    -- },

    overrides = function(colors)
      local palette = colors.palette
      local theme = colors.theme

      return {
        --
        -- -- -- NvimSurroundHighlight = { bg = theme.ui.fg },
        -- -- TelescopeBorder = { bg = "NONE" },
        -- -- TelescopeNormal = { fg = theme.ui.fg_dim },
        -- -- NoiceLspProgressSpinner = { fg = theme.ui.fg, bg = "NONE" },
        -- -- NoiceLspProgressTitle = { fg = theme.ui.fg, bg = "NONE" },
        -- -- NoiceLspProgressClient = { bg = "NONE" },
        -- -- FloatFooter = { bg = "NONE" },
        -- TelescopeNormal = { bg = theme.ui.bg },
        -- TelescopeBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg },
        -- TelescopePromptNormal = { bg = theme.ui.bg },
        -- TelescopePromptPrefix = { bg = theme.ui.bg },
        -- TelescopePromptCounter = { bg = theme.ui.bg },
        --
        -- -- TelescopeBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg },
        --
        -- NoiceFormatConfirm = { bg = theme.ui.bg },
        --
        -- -- Pmenu = { bg = "#000000" }, -- add `blend = vim.o.pumblend` to enable transparency
        -- -- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        --
        -- -- PmenuSbar = { bg = theme.ui.bg_m1 },
        -- -- PmenuThumb = { bg = theme.ui.bg_p2 },
        --
        -- -- DiagnosticUnnecessary = { fg = "NONE", undercurl = true, sp = theme.diag.info },
        --
        -- -- NotifyBackground = { bg = theme.ui.bg },

        -- FloatBorder = { fg = theme.ui.bg, bg = palette.sumiInk4 },

        -- WinSeparator = { fg = theme.ui.bg_p1 },
        -- WinSeparator = { fg = palette.sumiInk5 },

        -- ColorColumn = { bg = colors.palette.sumiInk1 },
        --
        -- NavicText = { fg = theme.ui.fg_dim },

        -- MiniIndentscopeSymbol = { fg = palette.sumiInk6 },
        -- MiniIndentscopeSymbolOff = { fg = palette.sumiInk6 },
      }
    end,
  })
end

return M
