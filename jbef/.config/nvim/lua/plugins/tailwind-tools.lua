-- tailwind-tools.lua
local M = {
  "luckasRanarison/tailwind-tools.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {}, -- your configuration
}

function M.config()
  require("tailwind-tools").setup({})
end

return M
