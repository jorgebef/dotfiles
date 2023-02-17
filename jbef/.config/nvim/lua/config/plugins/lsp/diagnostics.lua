local M = {}

local ui = require("config.ui")

M.signs = {
  Error = ui.diagnostics.Error,
  Warning = ui.diagnostics.Warning,
  Hint = ui.diagnostics.Hint,
  Information = ui.diagnostics.Information,
}

function M.setup()
  for type, icon in pairs(M.signs) do
    -- local hl = "LspDiagnosticsSign" .. type
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return M
