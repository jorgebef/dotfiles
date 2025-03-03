return {
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy",
  -- enabled = true,

  config = function()
    local smart_splits = require("smart-splits")

    smart_splits.setup({
      at_edge = "stop",
      default_amount = 2,
    })

    -- moving between splits
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

    -- resizing between splits
    vim.keymap.set("n", "⇇", require("smart-splits").resize_left)
    vim.keymap.set("n", "⇊", require("smart-splits").resize_down)
    vim.keymap.set("n", "⇈", require("smart-splits").resize_up)
    vim.keymap.set("n", "⇉", require("smart-splits").resize_right)
  end,
}
