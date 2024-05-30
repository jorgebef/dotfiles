local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "SmiteshP/nvim-navic" },
    { "folke/neodev.nvim" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },

    { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
}

M.on_attach = require("plugins.lsp.on_attach").on_attach
M.capabilities = require("plugins.lsp.capabilities").setup
M.handlers = require("plugins.lsp.handlers").handlers

M.config = function()
  local servers = require("plugins.lsp.servers")
  local lsp = require("lspconfig")

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
    -- automatic_installation = { exclude = { "glslls", "tsserver" } },
    handlers = {
      function(server_name)
        lsp[server_name].setup({
          on_attach = M.on_attach,
          capabilities = M.capabilities(),
          handlers = M.handlers,
        })
      end,

      -- -- this is the "custom handler" for `tsserver`
      -- ["typescript-tools"] = function()
      -- local typescript_tools = require("typescript-tools")
      -- typescript_tools.setup({
      --   single_file_support = false,
      --   on_attach = function(client, bufnr)
      --     M.on_attach(client, bufnr)
      --   end,
      --   capabilities = M.capabilities(),
      --   handlers = M.handlers,
      --   settings = {
      --     root_dir = function(...)
      --       return require("lspconfig.util").root_pattern(".git")(...)
      --     end,
      --     tsserver_file_preferences = {
      --       includeInlayParameterNameHints = "all",
      --       includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      --       includeInlayFunctionParameterTypeHints = true,
      --       includeInlayVariableTypeHints = true,
      --       includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      --       includeInlayPropertyDeclarationTypeHints = true,
      --       includeInlayFunctionLikeReturnTypeHints = true,
      --       includeInlayEnumMemberValueHints = true,
      --
      --       includeCompletionsForModuleExports = true,
      --       quotePreference = "auto",
      --     },
      --     tsserver_format_options = {
      --       allowIncompleteCompletions = false,
      --       allowRenameOfImportPath = false,
      --     },
      --   },
      -- })
      -- end,
    },
  })

  require("plugins.lsp.keymaps").common()

  -- -- HERE IS WHERE THE MAGIG HAPPENS
  -- -- we loop through each item in the object provided with all the configs
  -- -- inside and setup each server individually, applying the default
  -- -- on_attach function, capabilities and all options set above
  -- for server, opts in pairs(servers) do
  --   opts = vim.tbl_deep_extend("force", {
  --     on_attach = M.on_attach,
  --     capabilities = M.capabilities(),
  --     handlers = M.handlers,
  --     -- flags = {
  --     --   debounce_text_changes = 150,
  --     -- },
  --     -- inlay_hints = { enabled = true },
  --   }, opts or {})
  --
  --   -- Need to remove tsserver since typescript-tools plugin replaces nvim-lspconfig entirely
  --   -- for a more performant tsserver native API access, instead of going through regular LSP
  --   -- ❗️ IMPORTANT: As mentioned earlier, this plugin serves as a replacement for typescript-language-server, so you should remove the nvim-lspconfig setup for it.
  --
  --   if server == "lua_ls" then
  --     require("neodev").setup({})
  --   elseif
  --     server ~= "test1"
  --     -- and server ~= "test2"
  --   then
  --     -- lspconfig[server].setup(coq.lsp_ensure_capabilities(opts))
  --     lspconfig[server].setup(opts)
  --   end
  -- end
  -- -- ALL DONE!
end

return M
