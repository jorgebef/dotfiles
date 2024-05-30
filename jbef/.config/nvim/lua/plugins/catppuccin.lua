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
  -- vim.g.catppuccin_flavour = "mocha"
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
      noice = true,
      symbols_outline = true,
      flash = true,
    },
    -- color_overrides = {
    --   mocha = {
    --     -- this 16 colors are changed to onedark
    --     base = "#282c34",
    --     mantle = "#353b45",
    --     surface0 = "#3e4451",
    --     surface1 = "#545862",
    --     surface2 = "#565c64",
    --     text = "#D3D6DE",
    --     rosewater = "#DDB1B1",
    --     lavender = "#A0ABF8",
    --     red = "#DC93A8",
    --     peach = "#DD996E",
    --     yellow = "#E1C894",
    --     green = "#A0CE9C",
    --     teal = "#97C3BF",
    --     blue = "#87AAE3",
    --     mauve = "#BEA1E3",
    --     flamingo = "#E9BEBE",
    --
    --     -- now patching extra palettes
    --     maroon = "#D897A2",
    --     sky = "#7CD0DF",
    --
    --     -- extra colors not decided what to do
    --     pink = "#EDB1DD",
    --     sapphire = "#67B9E0",
    --
    --     subtext1 = "#BAC2DE",
    --     subtext0 = "#A6ADC8",
    --     overlay2 = "#9399B2",
    --     overlay1 = "#7F849C",
    --     overlay0 = "#6C7086",
    --
    --     crust = "#11111B",
    --   },
    -- },
    custom_highlights = function(colors)
      return {
        -- UI elements
        -- ===============
        -- Pmenu = { bg = colors.mantle },
        PmenuSel = { fg = colors.pink, bg = colors.surface1 },
        -- NormalFloat = { bg = colors.mantle },
        -- FloatBorder = { fg = colors.overlay0, bg = colors.base },

        CmpItemAbbrMatch = { fg = colors.text },
        CmpItemAbbrMatchFuzzy = { fg = colors.text },
        CmpItemMenu = { fg = colors.overlay0, bg = nil, italic = true },

        NeoTreeHiddenByName = { fg = colors.blue, bg = nil },
        NeoTreeDotfile = { fg = colors.subtext1, bg = nil },

        TelescopeNormal = { fg = colors.subtext0, bg = colors.bg },
        TelescopeBorder = { fg = colors.overlay1, bg = colors.bg },
        TelescopeMatching = { fg = colors.pink, bg = nil, bold = true },
        TelescopeSelection = { fg = colors.text, bg = colors.surface0 },
        TelescopeSelectionCaret = { fg = colors.pink, bg = colors.surface0 },
        TelescopePreviewBorder = { fg = colors.overlay1, bg = colors.bg },
        TelescopePreviewTitle = { fg = colors.overlay0, bg = colors.bg },
        TelescopePreviewNormal = { fg = colors.overlay2, bg = colors.bg },
        TelescopeResultsNormal = { fg = colors.overlay2, bg = colors.bg },
        TelescopePromptBorder = { fg = colors.overlay1, bg = colors.bg },
        TelescopePromptTitle = { fg = colors.overlay0, bg = colors.bg },
        TelescopePromptNormal = { fg = colors.overlay2, bg = colors.bg },
        TelescopePromptPrefix = { fg = colors.pink, bg = colors.bg },

        LeapLabelPrimary = { fg = colors.red, bg = colors.crust },

        MiniJump = { fg = colors.red, bg = nil, bold = true, underline = true },

        LspSignatureActiveParameter = { fg = colors.pink, bold = true },

        -- WinBar = { fg = colors.subtext0, bg = nil },
        WinBarInactive = { fg = colors.surface1, bg = nil },
        WinBarFilenameActive = { fg = colors.text, bg = nil, bold = false },
        WinBarFilenameInactive = { fg = colors.overlay0, bg = nil, bold = true },

        NavicText = { fg = colors.subtext0, bg = nil },

        -- WhichKeyFloat = { bg = colors.surface0 },
        -- WhichKeyBorder = { fg = colors.blue, bg = colors.surface0 },

        -- LSP Specific
        -- ===============
        DiagnosticUnnecessary = { sp = colors.teal, undercurl = true },
        -- DiagnosticUnderlineError = { fg = nil, sp = colors.red, bg = nil },

        -- Noice
        NoiceVirtualText = { fg = colors.subtext0 },

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
