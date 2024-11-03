local M = {
  "mellow-theme/mellow.nvim",
  branch = "main",
  priority = 1000, --https://github.com/folke/lazy.nvim#-colorschemes:~:text=%F0%9F%8C%88,Colorschemes
  enabled = false,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
  },
}

function M.config()
  require("mellow").setup()

  vim.g.mellow_highlight_overrides = {
    ["IblIndent"] = { link = "Normal" },
    ["IblScope"] = { fg = "#DC93A8" },
  }
  vim.cmd([[colorscheme mellow]])
end

return M
