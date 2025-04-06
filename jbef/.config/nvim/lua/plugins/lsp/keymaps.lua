local M = {}

-- local opts = { noremap = true, silent = true }

function M.common()
  -- local fzf = require("fzf-lua")
  ---@type Util
  -- local util = require("util.util")

  -- =================================================
  -- Managed by snacks-nvim.lua
  -- =================================================

  -- vim.keymap.set("n", "gd", function()
  --   -- vim.lsp.buf.definition()
  --   -- require("telescope.builtin").lsp_definitions()
  --   Snacks.picker.lsp_definitions()
  -- end, { desc = "Goto definition" })

  -- vim.keymap.set("n", "gr", function()
  --   -- require("telescope.builtin").lsp_references()
  --   -- require("fzf-lua").lsp_references()
  --   Snacks.picker.lsp_references()
  -- end, { nowait = true, desc = "LSP references" })

  -- vim.keymap.set("n", "<leader>lD", function()
  --   vim.lsp.buf.type_definition()
  -- end, { desc = "Go to type definition" })

  -- =================================================

  vim.keymap.set("n", "]w", function()
    vim.diagnostic.jump({ count = 1, severity = { max = "WARN" }, float = true })
  end, { desc = "Goto next Warning" })

  vim.keymap.set("n", "]e", function()
    vim.diagnostic.jump({ count = 1, severity = "ERROR", float = true })
  end, { desc = "Goto next Error" })

  vim.keymap.set("n", "[w", function()
    vim.diagnostic.jump({ count = -1, severity = { max = "WARN" }, float = true })
  end, { desc = "Goto prev Warning" })

  vim.keymap.set("n", "[e", function()
    vim.diagnostic.jump({ count = -1, severity = "ERROR", float = true })
  end, { desc = "Goto prev Error" })

  vim.keymap.set("n", "<leader>lR", function()
    vim.cmd.LspRestart()
  end, { desc = "Restart LSP" })

  -- vim.keymap.set("n", "<leader>la", function()
  --   vim.lsp.buf.code_action()
  -- end, { desc = "Rename (inc-rename.nvim)", expr = true })

  vim.keymap.set("n", "<leader>lr", function()
    vim.lsp.buf.rename()
  end, { desc = "Rename symbol" })

  --  vim.keymap.set("n", "<leader>r", function()
  --   -- when rename opens the prompt, this autocommand will trigger
  --   -- it will "press" CTRL-F to enter the command-line window `:h cmdwin`
  --   -- in this window I can use normal mode keybindings
  --   local cmdId
  --   cmdId = vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
  --       callback = function()
  --         local key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
  --         vim.api.nvim_feedkeys(key, "c", false)
  --         vim.api.nvim_feedkeys("0", "n", false)
  --         -- autocmd was triggered and so we can remove the ID and return true to delete the autocmd
  --         cmdId = nil
  --         return true
  --       end,
  --     })
  --   vim.lsp.buf.rename()
  --   -- if LPS couldn't trigger rename on the symbol, clear the autocmd
  --   vim.defer_fn(function()
  --       -- the cmdId is not nil only if the LSP failed to rename
  --       if cmdId then
  --         vim.api.nvim_del_autocmd(cmdId)
  --       end
  --     end, 500)
  -- end, bufoptsWithDesc("Rename symbol"))

  vim.keymap.set("n", "gK", function()
    vim.lsp.buf.signature_help()
  end, { desc = "LSP Signature help" })

  vim.keymap.set("i", "<C-k>", function()
    vim.lsp.buf.signature_help()
  end, { desc = "LSP Signature help" })

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, { desc = "LSP hover" })

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
  vim.keymap.set("n", "<leader>lI", function()
    -- local current_buffer = vim.api.nvim_get_current_buf()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "Toggle inlay hints" })

  if clientName == "typescript-tools" then
    vim.keymap.set("n", "<leader>lo", function()
      vim.cmd([[:TSToolsOrganizeImports]])
    end)

    vim.keymap.set("n", "<leader>lR", function()
      vim.cmd([[:TSToolsRenameFile]])
    end, { desc = "TSTools rename file" })

    vim.keymap.set("n", "<leader>lA", function()
      vim.cmd([[:TSToolsAddMissingImports]])
    end, { desc = "TSTools add all imports" })
  end
end

return M
