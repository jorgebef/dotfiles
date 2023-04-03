local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "jose-elias-alvarez/typescript.nvim" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "SmiteshP/nvim-navic" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
  },
}

M.handlers = require("config.plugins.lsp.handlers").handlers

M.on_attach = require("config.plugins.lsp.on_attach").on_attach

M.capabilities = function()
  local cmp = require("cmp_nvim_lsp")
  local capabilities = cmp.default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

M.config = function()
  local lspconfig = require("lspconfig")
  local ui = require("config.ui")
  local servers = require("config.plugins.lsp.servers")

  require("mason").setup()
  local server_names = {}
  local n = 0
  for k, _ in pairs(servers) do
    n = n + 1
    server_names[n] = k
  end
  require("mason-lspconfig").setup({
    ensure_installed = server_names,
    -- automatic_installation = { exclude = { "tsserver", "tailwindcss" } },
  })

  local diagnostic_signs = {
    Error = ui.diagnostics.Error,
    Warning = ui.diagnostics.Warning,
    Hint = ui.diagnostics.Hint,
    Information = ui.diagnostics.Information,
  }
  for type, icon in pairs(diagnostic_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Do not forget to use the on_attach function
  -- require 'lspconfig'.myserver.setup { handlers=handlers }
  -- To instead override globally
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  local function improved_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or ui.border.Single
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  vim.lsp.util.open_floating_preview = improved_floating_preview

  -- local add_bun_prefix = require("plugins.lsp.bun").add_bun_prefix
  -- local util = require("lspconfig.util")
  -- util.on_setup = util.add_hook_before(util.on_setup, add_bun_prefix)

  -- HERE IS WHERE THE MAGIG HAPPENS
  -- we loop through each item in the object provided with all the configs
  -- inside and setup each server individually, applying the default
  -- on_attach function, capabilities and all options set above
  for server, opts in pairs(servers) do
    opts = vim.tbl_deep_extend("force", {
      on_attach = M.on_attach,
      handlers = M.handlers,
      capabilities = M.capabilities(),
      flags = {
        debounce_text_changes = 150,
      },
    }, opts or {})

    if server == "tsserver" then
      -- This is for additional niceties like rename file and so on, check out keymaps.lua file
      require("typescript").setup({
        server = opts,
      })
    else
      lspconfig[server].setup(opts)
    end
  end
  -- ALL DONE!
end

return M
