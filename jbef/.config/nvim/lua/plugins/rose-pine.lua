return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  enabled = false,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
  },

  config = function()
    require("rose-pine").setup()
  end,
}
