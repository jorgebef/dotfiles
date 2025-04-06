local M = {}

local ui = require("config.ui")

M.diagnostic_signs = {
  Error = ui.icons.diagnostics.Error,
  Warn = ui.icons.diagnostics.Warning,
  Hint = ui.icons.diagnostics.Hint,
  Info = ui.icons.diagnostics.Information,
}

function M.setup()
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = M.diagnostic_signs.Error,
        [vim.diagnostic.severity.WARN] = M.diagnostic_signs.Warn,
        [vim.diagnostic.severity.HINT] = M.diagnostic_signs.Hint,
        [vim.diagnostic.severity.INFO] = M.diagnostic_signs.Info,
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      border = ui.border.Block,

      -- source = "always",
      header = "",
      prefix = function(_diagnostic, i, total)
        return " " .. i .. "/" .. total .. " ", "Comment"
      end,
    },
  })
end

return M
