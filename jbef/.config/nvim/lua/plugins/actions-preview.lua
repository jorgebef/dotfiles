return {
  "aznhe21/actions-preview.nvim",
  dependencies = { "folke/snacks.nvim" },
  -- enabled = false,
  config = function()
    require("actions-preview").setup({
      -- backend = { "snacks", "telescope", "minipick", "nui" },
    })
  end,
  keys = {
    {
      "<leader>la",
      function()
        require("actions-preview").code_actions()
      end,
    },
  },
}
