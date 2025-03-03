local M = {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  enabled = true,
}

function M.config()
  local comment = require("Comment")

  comment.setup({
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  })
end

return M
