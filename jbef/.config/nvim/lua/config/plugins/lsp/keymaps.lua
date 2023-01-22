local M = {}

function M.setup(client)
  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", "<leader>ld", function()
    -- vim.lsp.buf.definition()
    require("telescope.builtin").lsp_definitions()
  end, opts)
  vim.keymap.set("n", "<leader>lh", function()
    require("telescope.builtin").lsp_references()
  end, opts)

  vim.keymap.set("n", "<leader>lD", function()
    vim.lsp.buf.type_definition()
  end, opts)

  vim.keymap.set("n", "<leader>la", function()
    vim.lsp.buf.code_action()
  end, opts)

  vim.keymap.set("n", "]w", function()
    vim.diagnostic.goto_next({ severity = { max = "WARN" }, float = true })
  end, opts)
  vim.keymap.set("n", "]e", function()
    vim.diagnostic.goto_next({ severity = "ERROR", float = true })
  end, opts)
  vim.keymap.set("n", "[w", function()
    vim.diagnostic.goto_prev({ severity = { max = "WARN" }, float = true })
  end, opts)
  vim.keymap.set("n", "[e", function()
    vim.diagnostic.goto_prev({ severity = "ERROR", float = true })
  end, opts)

  vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, opts)

  vim.keymap.set("n", "<leader>lr", function()
    vim.lsp.buf.rename()
  end, opts)

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover({ focusable = false })
  end, opts)

  vim.keymap.set("n", "<leader>lI", function()
    vim.lsp.buf.implementation()
  end, opts)

  vim.keymap.set("i", "<C-k>", function()
    vim.lsp.buf.signature_help()
  end, opts)

  -- ====================================
  -- CONDITIONAL REMAPS
  -- ====================================
  if client.name == "tsserver" then
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({})
    ts_utils.setup_client(client)
    vim.keymap.set("n", "<leader>lo", function()
      vim.cmd.TSLspOrganize()
    end)
    vim.keymap.set("n", "<leader>lR", function()
      vim.cmd.TSLspRenameFile()
    end, opts)
    vim.keymap.set("n", "<leader>li", function()
      vim.cmd.TSLspImportAll()
    end, opts)
  end

  -- Show diagnostics under the cursor when holding position
  vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    command = "lua OpenDiagnosticIfNoFloat()",
    group = "lsp_diagnostics_hold",
  })
end

return M
