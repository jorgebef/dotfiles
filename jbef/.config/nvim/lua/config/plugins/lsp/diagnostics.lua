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

  -- Function to check if a floating dialog exists and if not
  -- then check for diagnostics under the cursor
  function OpenDialogIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    -- THIS IS FOR BUILTIN LSP
    vim.diagnostic.open_float(0, {
      scope = "cursor",
      focusable = false,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    })
    -- THIS IS FOR LSPSAGA
    -- vim.cmd.Lspsaga('show_cursor_diagnostics')
  end
end

return M
