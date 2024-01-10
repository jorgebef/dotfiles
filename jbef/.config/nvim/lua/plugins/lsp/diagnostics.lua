local M = {}

local ui = require("config.ui")

M.diagnostic_signs = {
  Error = ui.diagnostics.Error,
  Warning = ui.diagnostics.Warning,
  Hint = ui.diagnostics.Hint,
  Information = ui.diagnostics.Information,
}

function M.setup()
  vim.diagnostic.config({
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = M.diagnostic_signs.Error },
        { name = "DiagnosticSignWarn", text = M.diagnostic_signs.Warn },
        { name = "DiagnosticSignHint", text = M.diagnostic_signs.Hint },
        { name = "DiagnosticSignInfo", text = M.diagnostic_signs.Info },
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  for type, icon in pairs(M.diagnostic_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return M
