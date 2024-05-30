-- -- TURN ALL JSON INTO JSONC
-- vim.api.nvim_create_augroup("jsoncComments", { clear = true })
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = "json",
--   command = "set filetype=jsonc",
--   group = "jsoncComments",
-- })

vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  command = 'lua vim.highlight.on_yank { higroup="IncSearch", timeout=250 }',
  group = "highlight_yank",
})

vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufRead", "BufWinEnter" }, {
  pattern = "*[^{T}]",
  callback = function()
    vim.cmd([[setlocal cursorline]])
  end,
  group = "CursorLine",
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "neo-tree" then
      return
    end
    vim.cmd([[setlocal nocursorline]])
  end,
  group = "CursorLine",
})

-- vim.api.nvim_create_augroup("DockerComposeDetect", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufRead" }, {
--   pattern = { "*.docker-compose.yaml", "*.docker-compose.yml" },
--   callback = function()
--     vim.bo.filetype = "yaml.docker-compose"
--   end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    for _, client in pairs((vim.lsp.get_clients({}))) do
      if client.name == "tailwindcss" then
        client.server_capabilities.completionProvider.triggerCharacters =
          { '"', "'", "`", ".", "(", "[", "!", "/", ":" }
      end
    end
  end,
})
