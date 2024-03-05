local M = {
  "smjonas/inc-rename.nvim",
}

function M.config()
  require("inc_rename").setup()
end

return M
