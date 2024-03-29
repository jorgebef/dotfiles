local M = {}

function M.setup(client)
  -- local typescript = require("typescript-tools")
  local opts = { noremap = true, silent = true }
  -- local wk = require("which-key")

  -- ====================================
  -- Typescript specific remaps
  -- ====================================
  if client.name == "typescript-tools" then
    vim.keymap.set(
      "n",
      "<leader>li",
      function()
        local current_buffer = vim.api.nvim_get_current_buf()
        vim.lsp.inlay_hint.enable(current_buffer, not vim.lsp.inlay_hint.is_enabled(current_buffer))
      end,
      vim.tbl_deep_extend("force", {
        desc = "Toggle inlay hints",
      }, opts)
    )

    --  Global variable _G.typescriptDefinition is set when entering a *.tsx file
    --  via autocommand (check autocommands.lua file in config)
    vim.keymap.set("n", "<leader>lo", function()
      -- typescript.actions.organizeImports()
      vim.cmd([[:TSToolsOrganizeImports]])
    end)

    vim.keymap.set("n", "<leader>lR", function()
      -- vim.cmd.TypescriptRenameFile()
      vim.cmd([[:TSToolsRenameFile]])
      -- typescript.renameFile(source, target)
    end, opts)

    vim.keymap.set("n", "<leader>lA", function()
      -- typescript.actions.addMissingImports()
      vim.cmd([[:TSToolsAddMissingImports]])
    end, opts)
  end

  vim.keymap.set("n", "<leader>ld", function()
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "<leader>lh", function()
    -- vim.cmd.Lspsaga("lsp_finder")
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
    -- require("lspsaga.diagnostic"):goto_next({
    --   severity = {
    --     vim.diagnostic.severity.WARN,
    --     vim.diagnostic.severity.HINT,
    --     vim.diagnostic.severity.INFO,
    --   },
    -- })
    vim.diagnostic.goto_next({ severity = { max = "WARN" }, float = true })
  end, opts)
  vim.keymap.set("n", "]e", function()
    -- require("lspsaga.diagnostic"):goto_next({
    --   severity = vim.diagnostic.severity.ERROR,
    -- })
    vim.diagnostic.goto_next({ severity = "ERROR", float = true })
  end, opts)
  vim.keymap.set("n", "[w", function()
    -- require("lspsaga.diagnostic"):goto_prev({
    --   severity = {
    --     vim.diagnostic.severity.WARN,
    --     vim.diagnostic.severity.HINT,
    --     vim.diagnostic.severity.INFO,
    --   },
    -- })
    vim.diagnostic.goto_prev({ severity = { max = "WARN" }, float = true })
  end, opts)
  vim.keymap.set("n", "[e", function()
    -- require("lspsaga.diagnostic"):goto_prev({
    --   severity = vim.diagnostic.severity.ERROR,
    -- })
    vim.diagnostic.goto_prev({ severity = "ERROR", float = true })
  end, opts)

  vim.keymap.set("n", "<leader>lS", function()
    vim.cmd.LspRestart()
  end, opts)

  vim.keymap.set("n", "<leader>lf", function()
    require("conform").format({ async = true, lsp_fallback = true }) -- managed by conform.lua
    -- vim.lsp.buf.format({ async = true })
  end, opts)

  vim.keymap.set("n", "<leader>lr", function()
    -- vim.cmd.Lspsaga("rename")
    -- vim.lsp.buf.rename()
    return ":IncRename "
  end, { expr = true })

  vim.keymap.set("n", "K", function()
    -- vim.cmd.Lspsaga("hover_doc", "++quiet")
    vim.lsp.buf.hover({ focusable = false })
  end, opts)

  vim.keymap.set("i", "<C-k>", function()
    vim.lsp.buf.signature_help()
  end, opts)

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.server_capabilities.hoverProvider then
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
      end
    end,
  })

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

return M
