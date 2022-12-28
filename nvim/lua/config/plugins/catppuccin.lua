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
      leap = true,
    },
    custom_highlights = {
      -- UI elements
      -- ===============================================================================
      Pmenu = { bg = cp.base },
      PmenuSel = { fg = cp.text, bg = cp.surface1, bold = true },
      NormalFloat = { bg = cp.base },
      FloatBorder = { fg = cp.blue, bg = cp.base },

      CmpItemAbbrMatch = { fg = cp.pink },
      CmpItemAbbrMatchFuzzy = { fg = cp.pink },
      CmpItemMenu = { fg = cp.overlay0, bg = nil, italic = true },

      TelescopeNormal = { fg = cp.subtext0 },

      LeapLabelPrimary = { fg = nil, bg = cp.mauve, bold = true },

      LspSagaFinderSelection = { fg = cp.blue, bg = cp.surface0 },
      FinderSpinnerBorder = { fg = cp.blue, bg = cp.base },
      FinderVirtText = { fg = cp.mauve },
      LspSagaLspFinderBorder = { fg = cp.blue, bg = cp.base },
      FinderPreviewSearch = { bg = cp.base },
      LspSagaHoverBorder = { fg = cp.blue, bg = cp.base },
      LspFloatWinNormal = { bg = cp.base },
      LspFloatWinBorder = { fg = cp.blue, bg = cp.base },
      LspSagaBorderTitle = { fg = cp.blue, bg = cp.red },
      DefinitionBorder = { fg = cp.blue, bg = cp.base },
      DefinitionArrow = { fg = cp.red, bg = cp.base },
      DefinitionSearch = { fg = nil, bg = cp.surface0 },
      DefinitionFile = { bg = cp.base },
      LSOutlinePreviewBorder = { fg = cp.blue, bg = cp.base },
      LspSagaRenameBorder = { fg = cp.blue, bg = cp.base },

      MiniJump = { fg = nil, bg = cp.surface1, underline = true },

      LspSignatureActiveParameter = { fg = cp.pink, bold = true },

      WinBar = { fg = cp.text, bg = cp.mantle },
      WinBarInactive = { fg = cp.surface2, bg = cp.mantle },
      WinBarFilenameActive = { fg = cp.base, bg = cp.pink, bold = true },
      WinBarFilenameInactive = { fg = cp.subtext0, bg = cp.mantle, bold = true },

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
end

return M
