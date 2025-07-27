return {
  "webhooked/kanso.nvim",
  lazy = false,
  priority = 1000,
  enabled = false,
  -- dev = true,
  -- dir = "~/Developer/other/kanso.nvim/",

  config = function()
    require("kanso").setup({
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = {},
      typeStyle = {},
      disableItalics = false,
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = { zen = {}, pearl = {}, ink = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        return {
          WinSeparator = { fg = colors.palette.inkBlack3 },
          WinBar = { fg = colors.theme.ui.fg },
          WinBarNC = { fg = colors.palette.inkBlack3 },
          BlinkCmpMenuBorder = { fg = colors.palette.inkBlack2 },
        }
      end,
      theme = "zen", -- Load "zen" theme
      background = { -- map the value of 'background' option to a theme
        dark = "zen", -- try "ink" !
        light = "pearl",
      },
    })

    -- vim.cmd([[colorscheme kanso]])
  end,
}
