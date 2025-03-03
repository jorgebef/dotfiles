local M = {}

M.on_attach = function(client, bufnr)
  local navic = require("nvim-navic")
  local util = require("util.util")

  -- if client.supports_method("textDocument/inlayHint") then
  --   vim.lsp.inlay_hint.enable(bufnr, false)
  -- end
  -- vim.lsp.inlay_hint.enable(false, false)

  require("plugins.lsp.keymaps").specific(client.name)

  if
    not util.has_value({
      "tailwindcss",
      "cssmodules_ls",
      "css_variables",
      "glslls",
      "eslint_d",
      "eslint",
      "biome",
      "efm",
      "docker_compose_language_service",
    }, client.name)
  then
    navic.attach(client, bufnr)
  end

  -- Conditionally disable formatting for some servers
  if util.has_value({
    "lua_ls",
    "ts_ls",
  }, client.name) then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

return M
