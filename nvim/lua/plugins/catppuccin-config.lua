local catppuccin = require("catppuccin")

-- IMPORTANT!!!!!!!!!
vim.g.catppuccin_flavour = "mocha"
local cp = require("catppuccin.palettes").get_palette()

catppuccin.setup({
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  transparent_background = false,
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
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    coc_nvim = false,
    lsp_trouble = false,
    cmp = true,
    lsp_saga = true,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = true,
      transparent_panel = false,
    },
    neotree = {
      enabled = false,
      show_root = true,
      transparent_panel = false,
    },
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    dashboard = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = false,
    markdown = true,
    lightspeed = false,
    ts_rainbow = false,
    hop = false,
    notify = true,
    telekasten = false,
    symbols_outline = true,
    mini = false,
  },
  -- color_overrides = {},
  -- highlight_overrides = {},
  custom_highlights = {
    -- UI elements
    -- ===============================================================================
    Pmenu = { bg = cp.surface0 },
    PmenuSel = { fg = cp.text, bg = cp.surface1, bold = true },
    NormalFloat = { bg = cp.surface0 },
    FloatBorder = { fg = cp.blue, bg = cp.surface0 },

    CmpItemAbbrMatch = { fg = cp.pink },
    CmpItemAbbrMatchFuzzy = { fg = cp.pink },

    TelescopeNormal = { fg = cp.subtext0 },
    -- TelescopeSelection = { fg = cp.text, bg = cp.surface0, bold = true },
    -- TelescopePreviewTitle = { fg = cp.blue },
    -- TelescopeResultsTitle = { fg = cp.blue },
    -- TelescopePromptTitle = { fg = cp.blue },
    -- TelescopeMatching = { fg = cp.pink },
    -- TelescopeSelectionCaret = { fg = cp.red, bg = cp.surface0 },

    -- LspSagaFinderSelection = { fg = cp.blue, bg = cp.base },
    -- FinderSpinnerBorder = { fg = cp.blue, bg = cp.base },
    -- LspSagaLspFinderBorder = { fg = cp.blue, bg = cp.base },
    -- FinderPreviewSearch = { bg = cp.base },
    -- LspSagaHoverBorder = { fg = cp.blue, bg = cp.base },
    -- LspFloatWinNormal = { bg = cp.base },
    -- LspFloatWinBorder = { fg = cp.blue, bg = cp.base },
    -- LspSagaBorderTitle = { fg = cp.blue, bg = cp.red },
    -- DefinitionBorder = { fg = cp.blue, bg = cp.base },
    -- DefinitionArrow = { fg = cp.red, bg = cp.base },
    -- -- DefinitionSearch = { fg = cp.red },
    -- DefinitionFile = { bg = cp.base },
    -- LSOutlinePreviewBorder = { fg = cp.blue, bg = cp.base },
    -- LspSagaRenameBorder = { fg = cp.blue, bg = cp.base },

    LspSignatureActiveParameter = { fg = cp.pink, bold = true },

    WinBar = { fg = cp.text, bg = cp.base },
    WinBarInactive = { fg = cp.surface2, bg = cp.base },
    -- WinBarModActive = { fg = cp.red, bg = cp.base },
    -- WinBarModInactive = { fg = cp.red, bg = cp.base },
    WinBarFilenameActive = { fg = cp.base, bg = cp.pink, bold = true },
    WinBarFilenameInactive = { fg = cp.subtext0, bg = cp.base, bold = true },
    -- WinBarModified = { fg = cp.red },

    WhichKeyFloat = { bg = cp.surface0 },
    WhichKeyBorder = { fg = cp.blue, bg = cp.surface0 },
    -- ===============================================================================
    -- Language specific
    -- ===============================================================================
    tsxTSTagDelimiter = { fg = cp.maroon },
    ["@tag.delimiter.tsx"] = { fg = cp.maroon },
    jsxTSTagDelimiter = { fg = cp.maroon },
    javascriptTSTagDelimiter = { fg = cp.maroon },
  },
})
