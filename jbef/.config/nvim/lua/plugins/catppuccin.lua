local M = {
  "catppuccin/nvim",
  branch = "main",
  name = "catppuccin",
  build = ":CatppuccinCompile",
  priority = 1000, --https://github.com/folke/lazy.nvim#-colorschemes:~:text=%F0%9F%8C%88,Colorschemes
  enabled = false,
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
      enabled = false,
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
      notify = true,
      noice = true,
      symbols_outline = true,
      flash = true,
    },
    -- color_overrides = {
    --   mocha = {
    --     -- this 16 colors are changed to onedark
    --     base = "#222630",
    --     mantle = "#1E222A",
    --     surface0 = "#2E3440",
    --     surface1 = "#2E3440",
    --     surface2 = "#3B4252",
    --     text = "#D8DEE9",
    --     rosewater = "#60728A",
    --     lavender = "#BE9DB8",
    --     red = "#BF616A",
    --     peach = "#D08770",
    --     yellow = "#EBCB8B",
    --     green = "#A3BE8C",
    --     teal = "#8FBCBB",
    --     blue = "#5E81AC",
    --     mauve = "#B48EAD",
    --     flamingo = "#D79784",
    --
    --     -- now patching extra palettes
    --     maroon = "#D897A2",
    --     sky = "#7CD0DF",
    --
    --     -- extra colors not decided what to do
    --     pink = "#EDB1DD",
    --     sapphire = "#67B9E0",
    --
    --     subtext1 = "#4C566A",
    --     subtext0 = "#434C5E",
    --     overlay2 = "#4C566A",
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
        Pmenu = { fg = nil, bg = colors.surface0 },
        PmenuSel = { fg = colors.pink, bg = colors.surface0 },

        CmpItemAbbrMatch = { fg = colors.text },
        CmpItemAbbrMatchFuzzy = { fg = colors.text },
        CmpItemMenu = { fg = colors.overlay0, bg = colors.surface0, italic = true },
        FloatBorder = { fg = colors.surface0, bg = colors.surface0 },

        NeoTreeHiddenByName = { fg = colors.blue, bg = nil },
        NeoTreeDotfile = { fg = colors.subtext1, bg = nil },

        TelescopeNormal = { fg = colors.subtext0, bg = colors.mantle },
        TelescopeBorder = { fg = colors.surface0, bg = colors.mantle },
        TelescopeMatching = { fg = colors.pink, bg = nil, bold = true },
        TelescopeSelection = { fg = colors.text, bg = colors.surface0 },
        TelescopeSelectionCaret = { fg = colors.pink, bg = colors.surface0 },
        TelescopePreviewBorder = { fg = colors.surface0, bg = colors.mantle },
        TelescopePreviewTitle = { fg = colors.surface0, bg = colors.mantle },
        TelescopePreviewNormal = { fg = colors.overlay2, bg = colors.mantle },
        TelescopeResultsNormal = { fg = colors.overlay1, bg = colors.mantle },
        TelescopePromptBorder = { fg = colors.surface0, bg = colors.mantle },
        TelescopePromptTitle = { fg = colors.surface0, bg = colors.mantle },
        TelescopePromptNormal = { fg = colors.overlay2, bg = colors.mantle },
        TelescopePromptPrefix = { fg = colors.pink, bg = colors.mantle },

        LeapLabelPrimary = { fg = colors.red, bg = colors.crust },

        MiniJump = { fg = colors.red, bg = nil, bold = true, underline = true },

        LspSignatureActiveParameter = { fg = colors.pink, bold = true },

        WinBarInactive = { fg = colors.surface1, bg = colors.bg },
        WinBarFilenameActive = { fg = colors.text, bg = colors.bg, bold = false },
        WinBarFilenameInactive = { fg = colors.overlay0, bg = colors.bg, bold = true },

        NavicText = { fg = colors.subtext0, bg = nil },

        -- LSP Specific
        -- ===============
        DiagnosticUnnecessary = { sp = colors.teal, undercurl = true },
        -- DiagnosticUnderlineError = { fg = nil, sp = colors.red, bg = nil },

        -- Noice
        NoiceVirtualText = { fg = colors.subtext0 },

        -- Language specific
        -- ===============
        ["@tag.delimiter.tsx"] = { fg = colors.overlay1 },
        ["@tag.attribute.tsx"] = { fg = colors.blue },
        ["@constructor.tsx"] = { fg = colors.peach },

        ["@constructor.typescript"] = { fg = colors.blue },

        -- ["@lsp.typemod.property.declaration.string_fragment.typescript"] = { fg = colors.peach },
        ["@string_fragment.typescript"] = { fg = colors.peach },
      }
    end,
  })
end

return M
