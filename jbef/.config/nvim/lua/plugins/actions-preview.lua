local M = {
  "aznhe21/actions-preview.nvim",
  config = function()
    require("actions-preview").setup({
      -- backend = { "nui", "telescope" },
      telescope = {
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.6,
          height = 0.8,
          prompt_position = "top",
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      },
    })

    -- vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)

    ---@type Util
    local util = require("util.util")

    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>la", function()
      -- vim.cmd.Lspsaga("code_action")
      -- vim.lsp.buf.code_action()
      require("actions-preview").code_actions()
      -- fzf.lsp_code_actions()
    end, util.table_merge(opts, { desc = "Code actions" }))
  end,
}

return M
