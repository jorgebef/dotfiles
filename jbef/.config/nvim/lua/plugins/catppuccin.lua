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
        -- virtual_text = {
        -- errors = { "italic" },
        -- hints = { "italic" },
        -- warnings = { "italic" },
        -- information = { "italic" },
        -- },
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
        inlay_hints = {
          background = true,
        },
      },
      cmp = true,
      navic = {
        enabled = true,
        custom_bg = "NONE",
      },
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
        TelescopePromptBorder = { fg = colors.mantle, bg = colors.mantle },
        TelescopePromptTitle = { fg = colors.base, bg = colors.mantle },
        TelescopePromptNormal = { fg = colors.overlay2, bg = colors.mantle },
        TelescopePromptPrefix = { fg = colors.pink, bg = colors.mantle },

        LeapLabelPrimary = { fg = colors.red, bg = colors.crust },

        MiniJump = { fg = colors.red, bg = nil, bold = true, underline = true },

        LspSignatureActiveParameter = { fg = colors.pink, bold = true },

        -- WinBar = { fg = colors.subtext0, bg = nil },
        WinBarInactive = { fg = colors.surface1, bg = nil },
        WinBarFilenameActive = { fg = colors.text, bg = nil, bold = true },
        WinBarFilenameInactive = { fg = colors.overlay0, bg = nil, bold = true },

        NavicText = { fg = colors.subtext0, bg = nil },

        -- WhichKeyFloat = { bg = colors.surface0 },
        -- WhichKeyBorder = { fg = colors.blue, bg = colors.surface0 },

        -- LSP Specific
        -- ===============
        DiagnosticUnnecessary = { sp = colors.teal, undercurl = true },
        -- DiagnosticUnderlineError = { fg = nil, sp = colors.red, bg = nil },

        -- Language specific
        -- ===============
        ["@tag.delimiter.tsx"] = { fg = colors.overlay2 },
        ["@tag.attribute.tsx"] = { fg = colors.blue },
        ["@constructor.tsx"] = { fg = colors.peach },
        -- ["@lsp.typemod.property.declaration.string_fragment.typescript"] = { fg = colors.peach },
        ["@string_fragment.typescript"] = { fg = colors.peach },
      }
    end,
  })
end

return M
