return {
  "smart-splits-nvim/smart-splits.nvim",
  version = "^3.0.0",
  dependencies = {
    {
      "rawnly/smart-splits-nvim--backend-rex",
      opts = {
        -- bin = 'rex',     -- name or path of the rex executable
        -- timeout = 2000,  -- ms to wait for a rex command
      },
    },
  },
  -- enabled = true,

  config = function()
    local smart_splits = require("smart-splits")

    smart_splits.setup({
      mux = {
        backend = "smart-splits-backend-rex",
      },
      move = { at_edge = "stop" },
    })

    -- moving between splits
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

    -- resizing between splits
    vim.keymap.set("n", "<C-S-h>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<C-S-j>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<C-S-k>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<C-S-l>", require("smart-splits").resize_right)
  end,
}
