local M = {}

M.on_attach = function(client, bufnr)
  local navic = require("nvim-navic")
  local util = require("util.util")

  if client.name ~= "tailwindcss" then
    navic.attach(client, bufnr)
  end

  -- Conditionally disable formatting for some servers
  if util.has_value({
    "tsserver",
    "lua_ls",
  }, client.name) then
    client.server_capabilities.documentFormattingProvider = false
  end

  require("config.plugins.lsp.keymaps").setup(client)
end

return M
