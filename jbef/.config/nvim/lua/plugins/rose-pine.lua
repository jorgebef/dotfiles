return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      palette = {
        -- Override the builtin palette per variant
        main = {
          base = "#1C1B28",
          -- overlay = '#363738',
        },
      },
    })
    -- vim.cmd("colorscheme rose-pine")
  end,
}
