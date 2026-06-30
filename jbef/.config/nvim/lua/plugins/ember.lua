return {
  "ember-theme/nvim",
  name = "ember",
  priority = 1000,
  config = function()
    require("ember").setup({
      variant = "ember-soft", -- "ember" | "ember-soft" | "ember-light"
      on_highlights = function(highlights, theme)
        highlights.CursorLine.bg = theme.ui.base3
      end,
    })
    vim.cmd("colorscheme ember-soft")
  end,
}
