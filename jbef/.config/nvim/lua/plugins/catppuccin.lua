return {
  "catppuccin/nvim",
  enabled = true,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "underline" },
          ok = { "underline" },
        },
        -- inlay_hints = {
        --   background = true,
        -- },
      },
      color_overrides = {
        -- mocha = {
        --   red = "#ff657a",
        --   maroon = "#F29BA7",
        --   peach = "#ff9b5e",
        --   yellow = "#eccc81",
        --   green = "#a8be81",
        --   teal = "#9cd1bb",
        --   sky = "#A6C9E5",
        --   sapphire = "#86AACC",
        --   blue = "#6d91bf",
        --   lavender = "#8692bC",
        --   mauve = "#b18eab",
        --   text = "#fcfcfa",
        --   surface2 = "#535763",
        --   surface1 = "#3a3d4b",
        --   surface0 = "#30303b",
        --   base = "#20202a",
        --   mantle = "#1c1d24",
        --   crust = "#17171b",
        -- },
      },
      custom_highlights = function(colors)
        return {
          Comment = { fg = colors.surface2 },

          WinBar = { fg = colors.subtext0, bg = colors.base },
          WinBarMuted = { fg = colors.surface2, bg = colors.base },
          WinBarNC = { fg = colors.surface2, bg = colors.base },
          WinBarNCMuted = { fg = colors.surface1, bg = colors.base },

          WinSeparator = { fg = colors.surface0 },

          NormalFloat = { fg = colors.text, bg = colors.surface0 },
          FloatBorder = { fg = colors.surface0, bg = colors.surface0 },

          Pmenu = { fg = colors.text, bg = colors.surface0 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = colors.overlay2 },
          PmenuSbar = { bg = colors.overlay0 },
          PmenuThumb = { bg = colors.surface2 },
          BlinkCmpMenuBorder = { fg = colors.surface0, bg = colors.surface0 },
          BlinkCmpDoc = { fg = nil, bg = colors.surface0 },
          BlinkCmpDocBorder = { fg = colors.surface0, bg = colors.surface0 },
          BlinkCmpDocSeparator = { fg = colors.overlay2, bg = colors.surface0 },

          MiniIndentscopeSymbol = { fg = colors.surface2 },
          MiniIndentscopeSymbolOff = { fg = colors.surface0 },
        }
      end,
    })

    -- vim.cmd([[colorscheme catppuccin]])
  end,
}
