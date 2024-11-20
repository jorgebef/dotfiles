local M = {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
}

function M.config()
  local smart_splits = require("smart-splits")

  smart_splits.setup({
    at_edge = "stop",
  })

  -- moving between splits
  vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
  vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
  vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
  vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
end

return M
