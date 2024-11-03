local M = {
  "folke/persistence.nvim",
  enabled = true,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}

function M.config()
  local persistence = require("persistence")

  persistence.setup({
    dir = vim.fn.stdpath("state") .. "/sessions/", -- The directory where the session files will be saved.
    -- minimum number of file buffers that need to be open to save
    -- Set to 0 to always save
    need = 1,
    branch = true, -- use git branch to save session
  })

  vim.keymap.set("n", "<leader>sl", function()
    require("persistence").load()
  end)
end

return M
