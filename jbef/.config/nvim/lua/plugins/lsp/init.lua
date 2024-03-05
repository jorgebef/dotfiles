local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- { "ms-jpq/coq_nvim", branch = "coq" },
    { "SmiteshP/nvim-navic" },
    { "folke/neodev.nvim" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
  },
}

M.on_attach = require("plugins.lsp.on_attach").on_attach
M.capabilities = require("plugins.lsp.capabilities").setup
M.handlers = require("plugins.lsp.handlers").handlers

M.config = function()
  local lspconfig = require("lspconfig")
  local servers = require("plugins.lsp.servers")

  require("plugins.lsp.diagnostics").setup()

  require("mason").setup()
  local server_names = {}
  local n = 0
  for k, _ in pairs(servers) do
    if k ~= "glslls" then
      n = n + 1
      server_names[n] = k
    end
  end
  require("mason-lspconfig").setup({
    ensure_installed = server_names,
    automatic_installation = { exclude = { "glslls" } },
  })

  -- vim.cmd([[
  -- " let g:coq_settings = { 'auto_start': 'shut-up' }
  -- let g:coq_settings = { 'auto_start': v:true, 'match.max_results': 9999, 'limits.completion_auto_timeout': 50}
  -- ]])

  -- local coq = require("coq")

  -- -- Do not forget to use the on_attach function
  -- -- require 'lspconfig'.myserver.setup { handlers=handlers }
  -- -- To instead override globally
  -- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  -- local function improved_floating_preview(contents, syntax, opts, ...)
  --   opts = opts or {}
  --   opts.border = opts.border or ui.border.Block
  --   return orig_util_open_floating_preview(contents, syntax, opts, ...)
  -- end
  -- vim.lsp.util.open_floating_preview = improved_floating_preview

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
      capabilities = M.capabilities(),
      handlers = M.handlers,
      -- flags = {
      --   debounce_text_changes = 150,
      -- },
      -- inlay_hints = { enabled = true },
    }, opts or {})

    -- Need to remove tsserver since typescript-tools plugin replaces nvim-lspconfig entirely
    -- for a more performant tsserver native API access, instead of going through regular LSP
    -- ❗️ IMPORTANT: As mentioned earlier, this plugin serves as a replacement for typescript-language-server, so you should remove the nvim-lspconfig setup for it.

    if server == "lua_ls" then
      -- require("neodev").setup(coq.lsp_ensure_capabilities({}))
      require("neodev").setup({})
    end

    if
      server ~= "tsserver"
      -- server ~= "test1"
      -- and server ~= "test2"
    then
      -- lspconfig[server].setup(coq.lsp_ensure_capabilities(opts))
      lspconfig[server].setup(opts)
    end
  end
  -- ALL DONE!
end

return M
