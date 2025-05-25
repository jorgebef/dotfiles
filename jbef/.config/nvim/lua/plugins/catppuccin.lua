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
  require("catppuccin").setup({
    flavour = "mocha",
    dim_inactive = {
      enabled = false,
    },
    transparent_background = false,
    no_bold = true, -- Force no bold
    term_colors = false,
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
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
    },

    highlight_overrides = {
      mocha = function(colors)
        local u = require("catppuccin.utils.colors")
        local customFloatColor = u.brighten(colors.mantle, 0.10)
        return {
          --     -- UI elements
          --     -- ===============
          Pmenu = { fg = nil, bg = customFloatColor },
          --     PmenuSel = { fg = colors.pink, bg = colors.surface0 },
          -- FloatBorder = { fg = colors.mantle, bg = colors.mantle },
          -- NormalFloat = { bg = colors.mantle },
          FloatBorder = { fg = customFloatColor, bg = customFloatColor },
          NormalFloat = { bg = customFloatColor },
          -- BlinkCmpDoc = { bg = colors.surface0 },
          BlinkCmpMenuBorder = { fg = customFloatColor, bg = customFloatColor },
          BlinkCmpLabelMatch = { fg = colors.pink },
          -- BlinkCmpMenu = { fg = nil, bg = colors.surface0 },

          Comment = { fg = colors.overlay0 },
          CursorLine = { bg = u.brighten(colors.base, 0.09) },

          NavicText = { fg = colors.subtext0, bg = nil },
          WinBar = { fg = colors.text, bg = colors.base },
          WinBarNC = { fg = colors.surface1, bg = colors.base },

          NeoTreeNormal = { bg = customFloatColor },
          NeoTreeCursorLine = { bg = colors.surface1 },
          -- NeoTreeFloatBorder = { fg = colors.base, bg = colors.base },

          -- SnacksNormal = { bg = colors.base },
          -- SnacksPickerList = { bg = colors.base },
          -- SnacksPreview = { bg = colors.base },
          SnacksPickerPreview = { bg = colors.base },
          SnacksPickerPreviewBorder = { fg = customFloatColor, bg = colors.base },
          -- SnacksPickerBorder = { fg = colors.surface0 },
          SnacksPickerInputCursorLine = { bg = colors.base },

          --     -- LSP Specific
          --     -- ===============
          --     DiagnosticUnnecessary = { sp = colors.teal, undercurl = true },
          --     -- DiagnosticUnderlineError = { fg = nil, sp = colors.red, bg = nil },
          --
          --     -- Noice
          --     NoiceVirtualText = { fg = colors.subtext0 },

          -- Language specific
          -- ===============
          ["@tag.delimiter.tsx"] = { fg = colors.overlay1 },
          ["@tag.attribute.tsx"] = { fg = colors.blue },
          ["@constructor.tsx"] = { fg = colors.peach },

          --     ["@constructor.typescript"] = { fg = colors.blue },

          -- ["@lsp.typemod.property.declaration.string_fragment.typescript"] = { fg = colors.peach },
          ["@string_fragment.typescript"] = { fg = colors.peach },
        }
      end,
    },
  })
end

return M
