local M = {}

local ui = require("config.ui")
local utils = require("utils")
local navic = require("nvim-navic")

M.capabilities = require("blink.cmp").get_lsp_capabilities()

local function set_global_keymaps(client, bufnr)
  utils.keymap("n", "]w", function()
    vim.diagnostic.jump({ count = 1, severity = { max = "WARN" }, float = true })
  end, { desc = "Jump to next Warning" })

  utils.keymap("n", "]e", function()
    vim.diagnostic.jump({ count = 1, severity = "ERROR", float = true })
  end, { desc = "Jump to next Error" })

  utils.keymap("n", "[w", function()
    vim.diagnostic.jump({ count = -1, severity = { max = "WARN" }, float = true })
  end, { desc = "Jump to prev Warning" })

  utils.keymap("n", "[e", function()
    vim.diagnostic.jump({ count = -1, severity = "ERROR", float = true })
  end, { desc = "Jump to prev Error" })

  utils.keymap("n", "<leader>lR", vim.cmd.LspRestart, { desc = "Restart LSP" })

  utils.keymap("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })

  utils.keymap("n", "gK", vim.lsp.buf.signature_help, { desc = "LSP Signature help" })

  utils.keymap("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP Signature help" })

  utils.keymap("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })

  -- Function to check if a floating dialog exists and if not
  -- then check for diagnostics under the cursor
  function OpenDiagnosticIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    -- THIS IS FOR BUILTIN LSP
    vim.diagnostic.open_float({
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
  end

  -- Show errors and warnings in a floating window
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      -- OpenDiagnosticIfNoFloat()
      vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor", source = "if_many" })
    end,
  })
end

local function configure_diagnostics()
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = ui.icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = ui.icons.diagnostics.Warning,
        [vim.diagnostic.severity.HINT] = ui.icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = ui.icons.diagnostics.Information,
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      border = ui.border.Block,
      header = "",
      prefix = function(_diagnostic, i, total)
        return " " .. i .. "/" .. total .. " ", "Comment"
      end,
    },
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("global.lsp", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    set_global_keymaps(client, bufnr)
    configure_diagnostics()
  end,
})

vim.lsp.config("*", {
  capabilities = M.capabilities,
})

return M
