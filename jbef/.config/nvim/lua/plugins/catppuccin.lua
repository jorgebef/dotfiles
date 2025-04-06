local M = {
  "catppuccin/nvim",
  branch = "main",
  name = "catppuccin",
  build = ":CatppuccinCompile",
  priority = 1000, --https://github.com/folke/lazy.nvim#-colorschemes:~:text=%F0%9F%8C%88,Colorschemes
  enabled = true,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
  },
}

function M.config()
  ---@type CatppuccinOptions
  local opts = {}

  opts.flavour = "mocha"

  opts.dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  }

  opts.transparent_background = false

  opts.term_colors = false

  opts.compile_path = vim.fn.stdpath("cache") .. "/catppuccin"

  opts.styles = {
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
  }

  opts.integrations = {
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
    blink_cmp = true,
    navic = {
      enabled = true,
      custom_bg = "NONE",
    },
    lsp_saga = true,
    gitsigns = true,
    telescope = true,
    neotree = true,
    -- nvimtree = {
    --   enabled = true,
    --   show_root = true,
    --   transparent_panel = false,
    -- },
    which_key = true,
    indent_blankline = {
      enabled = true,
      scope_color = "overlay2",
      colored_indent_levels = false,
    },
    dashboard = true,
    markdown = true,
    notify = true,
    noice = true,
    symbols_outline = true,
    flash = true,
    snacks = true,
  }

  -- opts.color_overrides = {
  --   all = {
  --     text = "#cdd6f4",
  --     subtext1 = "#BAC2DE",
  --     subtext0 = "#A7AEC8",
  --     overlay2 = "#9399B1",
  --     overlay1 = "#80859B",
  --     overlay0 = "#6D7185",
  --     surface2 = "#5A5D6F",
  --     surface1 = "#464858",
  --     surface0 = "#333442",
  --     base = "#20202C",
  --     mantle = "#181822",
  --     crust = "#101018",
  --   },
  -- }

  opts.highlight_overrides = {
    all = function(colors)
      -- local util = require("catppuccin.utils.colors")
      return {
        BlinkCmpDoc = {
          bg = (opts.transparent_background and vim.o.pumblend == 0) and colors.none or colors.mantle,
        },
        BlinkCmpMenuBorder = {
          fg = colors.mantle,
          bg = (opts.transparent_background and vim.o.pumblend == 0) and colors.none or colors.mantle,
        },
        BlinkCmpLabelMatch = { fg = colors.pink, style = { "bold" } },
        FloatBorder = {
          fg = colors.mantle,
          bg = (opts.transparent_background and vim.o.winblend == 0) and colors.none or colors.base,
        },
        NeoTreeNormal = { bg = colors.base },
        NormalFloat = {
          fg = colors.text,
          bg = (opts.transparent_background and vim.o.winblend == 0) and colors.none or colors.base, -- lakjsdflkjasldfkj alsdkfj laksjdf lasjd flkaj sdflfkjalsdfkj
        },
        Pmenu = {
          fg = colors.overlay2,
          bg = (opts.transparent_background and vim.o.pumblend == 0) and colors.none or colors.mantle,
        },
        WinBarNC = { fg = colors.surface1, bg = colors.base },
        WinBar = { fg = colors.text, bg = colors.base, bold = false },
        ["@tag.delimiter.tsx"] = { fg = colors.overlay1 },
        ["@tag.attribute.tsx"] = { fg = colors.blue },
        ["@constructor.tsx"] = { fg = colors.peach },
        --     ["@constructor.typescript"] = { fg = colors.blue },
        -- ["@lsp.typemod.property.declaration.string_fragment.typescript"] = { fg = colors.peach },
        ["@string_fragment.typescript"] = { fg = colors.peach },
      }
    end,
  }

  -- custom_highlights = function(colors)
  --   local editor = require("catppuccin.groups.editor").get()
  --   return {
  --     --     -- UI elements
  --     --     -- ===============
  --     --     Pmenu = { fg = nil, bg = colors.surface0 },
  --     --     PmenuSel = { fg = colors.pink, bg = colors.surface0 },
  --     --
  --     --     CmpItemAbbrMatch = { fg = colors.text },
  --     --     CmpItemAbbrMatchFuzzy = { fg = colors.text },
  --     --     CmpItemMenu = { fg = colors.overlay0, bg = colors.surface0, italic = true },
  --     FloatBorder = { fg = colors.surface0 },
  --     BlinkCmpDoc = { bg = colors.surface0 },
  --     BlinkCmpMenuBorder = { fg = colors.base, bg = editor.Pmenu.bg },
  --     --
  --     --     NeoTreeHiddenByName = { fg = colors.blue, bg = nil },
  --     --     NeoTreeDotfile = { fg = colors.subtext1, bg = nil },
  --     --
  --     --     TelescopeNormal = { fg = colors.subtext0, bg = colors.mantle },
  --     --     TelescopeBorder = { fg = colors.surface0, bg = colors.mantle },
  --     --     TelescopeMatching = { fg = colors.pink, bg = nil, bold = true },
  --     --     TelescopeSelection = { fg = colors.text, bg = colors.surface0 },
  --     --     TelescopeSelectionCaret = { fg = colors.pink, bg = colors.surface0 },
  --     --     TelescopePreviewBorder = { fg = colors.surface0, bg = colors.mantle },
  --     --     TelescopePreviewTitle = { fg = colors.surface0, bg = colors.mantle },
  --     --     TelescopePreviewNormal = { fg = colors.overlay2, bg = colors.mantle },
  --     --     TelescopeResultsNormal = { fg = colors.overlay1, bg = colors.mantle },
  --     --     TelescopePromptBorder = { fg = colors.surface0, bg = colors.mantle },
  --     --     TelescopePromptTitle = { fg = colors.surface0, bg = colors.mantle },
  --     --     TelescopePromptNormal = { fg = colors.overlay2, bg = colors.mantle },
  --     --     TelescopePromptPrefix = { fg = colors.pink, bg = colors.mantle },
  --     --
  --     --     LeapLabelPrimary = { fg = colors.red, bg = colors.crust },
  --     --
  --     --     MiniJump = { fg = colors.red, bg = nil, bold = true, underline = true },
  --     --
  --     --     LspSignatureActiveParameter = { fg = colors.pink, bold = true },
  --
  --     WinbarNC = { fg = colors.surface1, bg = colors.base },
  --     Winbar = { fg = colors.text, bg = colors.base, bold = false },
  --
  --     --     NavicText = { fg = colors.subtext0, bg = nil },
  --     --
  --     --     -- LSP Specific
  --     --     -- ===============
  --     --     DiagnosticUnnecessary = { sp = colors.teal, undercurl = true },
  --     --     -- DiagnosticUnderlineError = { fg = nil, sp = colors.red, bg = nil },
  --     --
  --     --     -- Noice
  --     --     NoiceVirtualText = { fg = colors.subtext0 },
  --
  --     -- Language specific
  --     -- ===============
  --     ["@tag.delimiter.tsx"] = { fg = colors.overlay1 },
  --     ["@tag.attribute.tsx"] = { fg = colors.blue },
  --     ["@constructor.tsx"] = { fg = colors.peach },
  --
  --     --     ["@constructor.typescript"] = { fg = colors.blue },
  --
  --     -- ["@lsp.typemod.property.declaration.string_fragment.typescript"] = { fg = colors.peach },
  --     ["@string_fragment.typescript"] = { fg = colors.peach },
  --   }
  -- end,

  require("catppuccin").setup(opts)
end

return M
