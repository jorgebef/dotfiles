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
  -- local cp = require("catppuccin.palettes").get_palette()

  require("catppuccin").setup({
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
      leap = true,
    },
    custom_highlights = function(colors)
      return {
        -- UI elements
        -- ===============================================================================
        Pmenu = { bg = colors.base },
        PmenuSel = { fg = colors.text, bg = colors.surface1, bold = true },
        NormalFloat = { bg = colors.base },
        FloatBorder = { fg = colors.blue, bg = colors.base },

        CmpItemAbbrMatch = { fg = colors.pink },
        CmpItemAbbrMatchFuzzy = { fg = colors.pink },
        CmpItemMenu = { fg = colors.overlay0, bg = nil, italic = true },

        TelescopeNormal = { fg = colors.subtext0 },

        LeapLabelPrimary = { fg = nil, bg = colors.mauve, bold = true },

        LspSagaFinderSelection = { fg = colors.blue, bg = colors.surface0 },
        FinderSpinnerBorder = { fg = colors.blue, bg = colors.base },
        FinderVirtText = { fg = colors.mauve },
        LspSagaLspFinderBorder = { fg = colors.blue, bg = colors.base },
        FinderPreviewSearch = { bg = colors.base },
        LspSagaHoverBorder = { fg = colors.blue, bg = colors.base },
        LspFloatWinNormal = { bg = colors.base },
        LspFloatWinBorder = { fg = colors.blue, bg = colors.base },
        LspSagaBorderTitle = { fg = colors.blue, bg = colors.red },
        DefinitionBorder = { fg = colors.blue, bg = colors.base },
        DefinitionArrow = { fg = colors.red, bg = colors.base },
        DefinitionSearch = { fg = nil, bg = colors.surface0 },
        DefinitionFile = { bg = colors.base },
        LSOutlinePreviewBorder = { fg = colors.blue, bg = colors.base },
        LspSagaRenameBorder = { fg = colors.blue, bg = colors.base },

        MiniJump = { fg = nil, bg = colors.surface1, underline = true },

        LspSignatureActiveParameter = { fg = colors.pink, bold = true },

        WinBar = { fg = colors.text, bg = colors.mantle },
        WinBarInactive = { fg = colors.surface2, bg = colors.mantle },
        WinBarFilenameActive = { fg = colors.base, bg = colors.pink, bold = true },
        WinBarFilenameInactive = { fg = colors.subtext0, bg = colors.mantle, bold = true },

        WhichKeyFloat = { bg = colors.surface0 },
        WhichKeyBorder = { fg = colors.blue, bg = colors.surface0 },

        -- ===============================================================================
        -- Language specific
        -- ===============================================================================
        -- tsxTSTagDelimiter = { fg = cp.maroon },
        ["@tag.delimiter.tsx"] = { fg = colors.maroon },
        -- jsxTSTagDelimiter = { fg = cp.maroon },
        -- javascriptTSTagDelimiter = { fg = cp.maroon },
      }
    end,
  })
end

return M
