local M = { "echasnovski/mini.nvim" } -- Several small plugins in one

function M.config()
  --#####################################################
  -- BUFREMOVE
  --#####################################################
  local bufremove = require("mini.bufremove")
  bufremove.setup({})

  vim.keymap.set("n", "<leader>bd", function()
    -- Default values are 0 for current buffer and false for force
    -- https://github.com/echasnovski/mini.bufremove/blob/main/doc/mini-bufremove.txt
    -- See :h mini.bufremove
    bufremove.delete(0, false)
  end, { silent = true, nowait = true })

  --#####################################################
  -- JUMP
  --#####################################################
  local jump = require("mini.jump")
  jump.setup({
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      forward = "f",
      backward = "F",
      forward_till = "t",
      backward_till = "T",
      repeat_jump = ";",
    },
    -- Delay values (in ms) for different functionalities. Set any of them to
    -- a very big number (like 10^7) to virtually disable.
    delay = {
      -- Delay between jump and highlighting all possible jumps
      highlight = 0,
      -- Delay between jump and automatic stop if idle (no jump is done)
      idle_stop = 99999999,
    },
  })
end

return M
