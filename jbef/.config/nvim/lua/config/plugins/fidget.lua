local M = {
  "j-hui/fidget.nvim",
  tag = "legacy",
  event = "LspAttach",
}

function M.config()
  local fidget = require("fidget")

  fidget.setup({
    window = {
      relative = "editor", -- where to anchor, either "win" or "editor"
      blend = 0,
    },
  })
end

return M
