local utils = require("utils")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("typescript.lsp", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client.name == "typescript-tools" then
      utils.keymap("n", "<leader>lo", vim.cmd.TSToolsOrganizeImports)
      utils.keymap("n", "<leader>lR", vim.cmd.TSToolsRenameFile, { desc = "TSTools rename file" })
      utils.keymap("n", "<leader>lA", vim.cmd.TSToolsAddMissingImports, { desc = "TSTools add all imports" })
    end
  end,
})
