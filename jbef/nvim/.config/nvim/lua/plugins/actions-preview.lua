return {
  "aznhe21/actions-preview.nvim",
  -- dir = "~/Developer/other/actions-preview.nvim/",
  -- dev = true,
  dependencies = { "folke/snacks.nvim" },
  config = function()
    require("actions-preview").setup({
      backend = { "snacks", "telescope", "minipick", "nui" },
    })
  end,
  keys = {
    {
      mode = { "n", "v" },
      "<leader>la",
      function()
        require("actions-preview").code_actions()
      end,
      desc = "LSP code actions",
    },
    {
      mode = { "n", "v" },
      "<leader>lA",
      function()
        require("actions-preview").code_actions({
          range = {
            ["start"] = { 1, 1, vim.api.nvim_get_current_buf() },
            ["end"] = {
              vim.api.nvim_buf_line_count(vim.api.nvim_get_current_buf()),
              999,
              vim.api.nvim_get_current_buf(),
            },
          },
        })
      end,
      desc = "LSP code actions whole buffer",
    },
  },
}
