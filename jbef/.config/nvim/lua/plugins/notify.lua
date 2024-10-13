local M = {
  "rcarriga/nvim-notify",
}

function M.config()
  require("notify").setup({
    -- timeout = 3000,
    stages = "fade",
    -- on_open = function(win)
    --   vim.cmd([[echo "on_open"]])
    --   return
    -- end,
  })

  local banned_messages = { "Pattern not found" }

  vim.notify = function(msg, ...)
    -- for _, banned in ipairs(banned_messages) do
    --   if string.find(msg, "found") then
    --     require("notify")("KEKEKEKEKEKEKEKEK")
    --     return
    --   else
    --     require("notify")(msg, ...)
    --   end
    -- end
  end
end

return M
