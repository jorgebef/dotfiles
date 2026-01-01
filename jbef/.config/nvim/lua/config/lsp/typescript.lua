local utils = require("utils")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("typescript.lsp", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    -- utils.keymap("n", "<leader>lo", function()
    --   vim.lsp.buf.code_action({
    --     filter = function(action)
    --       if string.find(action.kind, "organizeImports.biome") or string.find(action.kind, "quickfix.biome") then
    --         vim.notify(action.kind)
    --       end
    --       return false
    --       -- for key, value in pairs(action) do
    --       --   vim.notify(key .. " ==> " .. value)
    --       -- end
    --       -- if
    --       --   action.kind == "source.organizeImports.biome"
    --       --   or action.kind == "source.fixAll.biome"
    --       --   or action.kind == "source.quickfix.biome"
    --       -- then
    --       --   return true
    --       -- end
    --     end,
    --   })
    -- end)

    -- utils.keymap("n", "<leader>lO", function()
    --   require("actions-preview").code_actions({
    --     range = {
    --       ["start"] = { 1, 1, vim.api.nvim_get_current_buf() },
    --       ["end"] = {
    --         vim.api.nvim_buf_line_count(vim.api.nvim_get_current_buf()),
    --         999,
    --         vim.api.nvim_get_current_buf(),
    --       },
    --     },
    --     filter = function(action)
    --       -- vim.notify(action.kind)
    --       if string.find(action.kind, "organizeImports.biome") or string.find(action.kind, "quickfix.biome") then
    --         return true
    --       end
    --     end,
    --     -- apply = true,
    --   })
    -- end)

    if client.name == "typescript-tools" then
      utils.keymap("n", "<leader>lO", vim.cmd.TSToolsOrganizeImports)
      utils.keymap("n", "<leader>lR", vim.cmd.TSToolsRenameFile, { desc = "TSTools rename file" })
      utils.keymap("n", "<leader>lI", vim.cmd.TSToolsAddMissingImports, { desc = "TSTools add all imports" })
    end
  end,
})

vim.lsp.config.ts_go_ls = {
  cmd = { "tsgo", "--lsp", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  tsserver_file_preferences = {
    importModuleSpecifierPreference = "non-relative",
    importModuleSpecifier = "non-relative",
  },
  jsx_close_tag = {
    enable = true,
    filetypes = { "javascriptreact", "typescriptreact" },
  },
  separate_diagnostic_server = true,
  -- publish_diagnostic_on = "insert_leave",
  -- documentRangeFormatting = false,
}
vim.lsp.enable("ts_go_ls")

-- vim.lsp.config.ts_ls = {
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescriptreact",
--     "typescript.tsx",
--   },
--   root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
-- }
-- vim.lsp.enable("ts_ls")
