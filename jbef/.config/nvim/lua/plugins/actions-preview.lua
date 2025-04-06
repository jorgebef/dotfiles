return {
  "aznhe21/actions-preview.nvim",
  enabled = false,
  config = function()
    require("actions-preview").setup({
      -- backend = { "nui", "telescope" },
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
