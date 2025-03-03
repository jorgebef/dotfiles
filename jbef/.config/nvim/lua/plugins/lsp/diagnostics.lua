local M = {}

local ui = require("config.ui")

M.diagnostic_signs = {
  Error = ui.diagnostics.Error,
  Warn = ui.diagnostics.Warning,
  Hint = ui.diagnostics.Hint,
  Info = ui.diagnostics.Information,
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
    -- border = ui.border.Block,
    float = {
      focusable = false,
      -- style = "minimal",
      -- border = "rounded",
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
