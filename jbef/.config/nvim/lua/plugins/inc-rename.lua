local M = {
  "smjonas/inc-rename.nvim",
  event = "LspAttach",
}

function M.config()
  require("inc_rename").setup()
end

return M
