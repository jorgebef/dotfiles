local M = {}

local opts = { noremap = true, silent = true }

function M.common()
  vim.keymap.set("n", "<leader>ld", function()
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "<leader>lh", function()
    require("telescope.builtin").lsp_references()
  end, opts)

  vim.keymap.set("n", "<leader>lD", function()
    vim.lsp.buf.type_definition()
  end, opts)

  vim.keymap.set("n", "<leader>la", function()
    -- vim.cmd.Lspsaga("code_action")
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

  vim.keymap.set("n", "<leader>lS", function()
    vim.cmd.LspRestart()
  end, opts)

  vim.keymap.set("n", "<leader>lf", function()
    require("conform").format({ async = true, lsp_fallback = true }) -- managed by conform.lua
  end, opts)

  vim.keymap.set("n", "<leader>lr", function()
    -- vim.lsp.buf.rename()
    return ":IncRename "
  end, { expr = true })

  vim.keymap.set("i", "<C-k>", function()
    vim.lsp.buf.signature_help()
  end, opts)

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  -- vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
  -- vim.api.nvim_create_autocmd("LspAttach", {
  --   callback = function(args)
  --     local client = vim.lsp.get_client_by_id(args.data.client_id)
  --     if client.server_capabilities.hoverProvider then
  --       vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
  --       -- vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
  --
  --       -- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  --     end
  --   end,
  -- })

  -- Function to check if a floating dialog exists and if not
  -- then check for diagnostics under the cursor
  function OpenDiagnosticIfNoFloat()
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
  end

  -- Show diagnostics under the cursor when holding position
  vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    command = "lua OpenDiagnosticIfNoFloat()",
    group = "lsp_diagnostics_hold",
  })
end

function M.specific(clientName)
  -- ====================================
  -- Typescript specific remaps
  -- ====================================
  vim.keymap.set(
    "n",
    "<leader>lI",
    function()
      -- local current_buffer = vim.api.nvim_get_current_buf()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
    vim.tbl_deep_extend("force", {
      desc = "Toggle inlay hints",
    }, opts)
  )

  if clientName == "tsserver" or clientName == "typescript-tools" then
    vim.keymap.set("n", "<leader>lo", function()
      vim.cmd([[:TSToolsOrganizeImports]])
    end)

    vim.keymap.set("n", "<leader>lR", function()
      vim.cmd([[:TSToolsRenameFile]])
    end, opts)

    vim.keymap.set("n", "<leader>lA", function()
      vim.cmd([[:TSToolsAddMissingImports]])
    end, opts)
  end
end

return M
