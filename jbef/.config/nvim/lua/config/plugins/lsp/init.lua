local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "jose-elias-alvarez/nvim-lsp-ts-utils" },
    { "jose-elias-alvarez/null-ls.nvim" },
    -- { "glepnir/lspsaga.nvim", branch = "main" },
    { "SmiteshP/nvim-navic" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
  },
}

M.handlers = {
  ["textDocument/hover"] = function(_, result, ctx, config)
    config = config or {}
    config.focus_id = ctx.method
    if not (result and result.contents) then
      return
    end
    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
    if vim.tbl_isempty(markdown_lines) then
      return
    end
    return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
  end,
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = require("config.ui").border.Single }
  ),
  ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    -- bold = true,
    signs = true,
    float = {
      source = "always",
      focusable = false,
    },
    severity_sort = true,
  }),
}

function M.on_attach(client, bufnr)
  local navic = require("nvim-navic")
  local util = require("util.util")

  if client.name ~= "tailwindcss" then
    navic.attach(client, bufnr)
  end

  -- Conditionally disable formatting for some servers
  if util.has_value({
    "tsserver",
    "sumneko_lua",
  }, client.name) then
    client.server_capabilities.documentFormattingProvider = false
  end

  require("config.plugins.lsp.keymaps").setup(client)
end

function M.capabilities()
  local cmp = require("cmp_nvim_lsp")
  local capabilities = cmp.default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

function M.config()
  local lspconfig = require("lspconfig")
  local ui = require("config.ui")
  local servers = require("config.plugins.lsp.servers")

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = servers,
  })

  require("config.plugins.lsp.diagnostics").setup()

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

    if server == "typescript" then
      require("config.plugins.lsp.typescript").setup(opts)
    else
      lspconfig[server].setup(opts)
      -- lspconfig[server].setup(require("coq").lsp_ensure_capabilities({}))
    end
  end
  -- ALL DONE!
end

return M
