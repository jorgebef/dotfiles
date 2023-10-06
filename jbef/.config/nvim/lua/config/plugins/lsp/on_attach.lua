local M = {}

M.on_attach = function(client, bufnr)
  local navic = require("nvim-navic")
  local util = require("util.util")

  if client.name ~= "tailwindcss" and client.name ~= "glslls" and client.name ~= "efm" then
    navic.attach(client, bufnr)
  end

  -- Conditionally disable formatting for some servers
  if util.has_value({
    "lua_ls",
    "tsserver",
  }, client.name) then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  require("config.plugins.lsp.keymaps").setup(client.name)
end

return M
