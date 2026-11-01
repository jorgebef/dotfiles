return {
  "xzbdmw/colorful-menu.nvim",
  enabled = true,
  config = function()
    -- You don't need to set these options.
    require("colorful-menu").setup({ ls = {}, fallback_highlight = "@variable", max_width = 60 })
  end,
}
