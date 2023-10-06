local M = {
  "catppuccin/nvim",
  branch = "main",
  name = "catppuccin",
  build = ":CatppuccinCompile",
  priority = 1000, --https://github.com/folke/lazy.nvim#-colorschemes:~:text=%F0%9F%8C%88,Colorschemes
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
  },
}

function M.config()
  -- IMPORTANT!!!!!!!!!
  vim.g.catppuccin_flavour = "mocha"

  require("catppuccin").setup({
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    transparent_background = true,
    term_colors = false,
    compile = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/catppuccin",
      suffix = "_compiled",
    },
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          -- errors = { "italic" },
          -- hints = { "italic" },
          -- warnings = { "italic" },
          -- information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      cmp = true,
      lsp_saga = true,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = true,
        transparent_panel = false,
      },
      which_key = true,
      indent_blankline = {
        enabled = true,
        scope_color = "overlay2",
        colored_indent_levels = false,
      },
      dashboard = true,
      markdown = true,
      notify = false,
      noice = false,
      symbols_outline = true,
      leap = true,
    },
    custom_highlights = function(colors)
      return {
        -- UI elements
        -- ===============
        Pmenu = { bg = colors.mantle },
        PmenuSel = { fg = colors.pink, bg = colors.surface1 },
        NormalFloat = { bg = colors.mantle },
        FloatBorder = { fg = colors.base, bg = colors.mantle },

        CmpItemAbbrMatch = { fg = colors.text },
        CmpItemAbbrMatchFuzzy = { fg = colors.text },
        CmpItemMenu = { fg = colors.overlay0, bg = nil, italic = true },

        -- CmpItemKindSnippet = { fg = colors.base, bg = colors.mauve },
        -- CmpItemKindKeyword = { fg = colors.base, bg = colors.red },
        -- CmpItemKindText = { fg = colors.base, bg = colors.teal },
        -- CmpItemKindMethod = { fg = colors.base, bg = colors.blue },
        -- CmpItemKindConstructor = { fg = colors.base, bg = colors.blue },
        -- CmpItemKindFunction = { fg = colors.base, bg = colors.blue },
        -- CmpItemKindFolder = { fg = colors.base, bg = colors.blue },
        -- CmpItemKindModule = { fg = colors.base, bg = colors.blue },
        -- CmpItemKindConstant = { fg = colors.base, bg = colors.peach },
        -- CmpItemKindField = { fg = colors.base, bg = colors.green },
        -- CmpItemKindProperty = { fg = colors.base, bg = colors.green },
        -- CmpItemKindEnum = { fg = colors.base, bg = colors.green },
        -- CmpItemKindUnit = { fg = colors.base, bg = colors.green },
        -- CmpItemKindClass = { fg = colors.base, bg = colors.yellow },
        -- CmpItemKindVariable = { fg = colors.base, bg = colors.flamingo },
        -- CmpItemKindFile = { fg = colors.base, bg = colors.blue },
        -- CmpItemKindInterface = { fg = colors.base, bg = colors.yellow },
        -- CmpItemKindColor = { fg = colors.base, bg = colors.red },
        -- CmpItemKindReference = { fg = colors.base, bg = colors.red },
        -- CmpItemKindEnumMember = { fg = colors.base, bg = colors.red },
        -- CmpItemKindStruct = { fg = colors.base, bg = colors.blue },
        -- CmpItemKindValue = { fg = colors.base, bg = colors.peach },
        -- CmpItemKindEvent = { fg = colors.base, bg = colors.blue },
        -- CmpItemKindOperator = { fg = colors.base, bg = colors.blue },
        -- CmpItemKindTypeParameter = { fg = colors.base, bg = colors.blue },
        -- CmpItemKindCopilot = { fg = colors.base, bg = colors.teal },

        TelescopeNormal = { fg = colors.subtext0, bg = colors.mantle },
        TelescopeBorder = { fg = colors.base, bg = colors.mantle },
        TelescopeMatching = { fg = colors.pink, bg = nil, bold = true },
        TelescopeSelection = { fg = colors.text, bg = colors.surface0 },
        TelescopeSelectionCaret = { fg = colors.pink, bg = colors.surface0 },
        TelescopePreviewBorder = { fg = colors.base, bg = colors.mantle },
        TelescopePreviewTitle = { fg = colors.base, bg = colors.mantle },
        TelescopePreviewNormal = { fg = colors.overlay2, bg = colors.mantle },
        TelescopeResultsNormal = { fg = colors.overlay2, bg = colors.mantle },
        -- TelescopeResultsBorder = { fg = colors.surface0, bg = colors.base },
        TelescopePromptBorder = { fg = colors.mantle, bg = colors.mantle },
        TelescopePromptTitle = { fg = colors.base, bg = colors.mantle },
        TelescopePromptNormal = { fg = colors.overlay2, bg = colors.mantle },
        TelescopePromptPrefix = { fg = colors.pink, bg = colors.mantle },

        -- FzfLuaNormal = { fg = colors.overlay2, bg = nil },
        -- FzfLuaBorder = { fg = colors.surface0, bg = nil },
        -- FzfLuaSearch = { fg = colors.pink, bg = nil },
        -- FzfLuaMatching = { fg = colors.pink, bg = nil, bold = true },
        -- FzfLuaPromptPrefix = { fg = colors.pink, bg = nil, bold = true },
        -- FzfLuaTitle = { fg = colors.pink, bg = nil, bold = true },
        -- FzfLuaCursor = { fg = colors.red, bg = colors.overlay2 },
        -- FzfLuaCursorLine = { fg = colors.text, bg = colors.overlay2 },
        -- FzfLuaPrompt = { fg = colors.blue, bg = colors.overlay2 },
        -- FzfLuaSelection = { fg = colors.text, bg = "#3B3D4F" },
        -- FzfLuaSelectionCaret = { fg = colors.pink, bg = colors.base },
        -- FzfLuaPreviewBorder = { fg = colors.surface0, bg = colors.base },
        -- FzfLuaPreviewTitle = { fg = colors.surface0, bg = colors.base },
        -- FzfLuaPreviewNormal = { fg = colors.overlay0, bg = colors.base },
        -- FzfLuaResultsNormal = { fg = colors.overlay2, bg = nil },
        -- -- TelescopeResultsBorder = { fg = colors.surface0, bg = colors.base },
        -- FzfLuaPromptNormal = { fg = colors.overlay2, bg = colors.base },

        LeapLabelPrimary = { fg = colors.red, bg = colors.crust },

        MiniJump = { fg = colors.red, bg = nil, bold = true, underline = true },

        LspSignatureActiveParameter = { fg = colors.pink, bold = true },

        WinBar = { fg = colors.subtext0, bg = nil },
        WinBarInactive = { fg = colors.surface1, bg = nil },
        WinBarFilenameActive = { fg = colors.base, bg = colors.pink, bold = true },
        WinBarFilenameInactive = { fg = colors.overlay2, bg = nil, bold = true },

        -- WhichKeyFloat = { bg = colors.surface0 },
        -- WhichKeyBorder = { fg = colors.blue, bg = colors.surface0 },

        -- LSP Specific
        -- ===============
        DiagnosticUnnecessary = { sp = colors.teal, underline = true },

        -- Language specific
        -- ===============
        ["@tag.delimiter.tsx"] = { fg = colors.overlay2 },
        ["@tag.attribute.tsx"] = { fg = colors.blue },
        ["@constructor.tsx"] = { fg = colors.peach },
      }
    end,
  })
end

return M
