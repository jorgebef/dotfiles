-- ❗️ IMPORTANT: As mentioned earlier, this plugin serves as a replacement for typescript-language-server, so you should remove the nvim-lspconfig setup for it.

local M = {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
}

M.on_attach = require("plugins.lsp.on_attach").on_attach
M.capabilities = require("plugins.lsp.capabilities").setup
M.handlers = require("plugins.lsp.handlers").handlers

function M.config()
  local typescript_tools = require("typescript-tools")

  typescript_tools.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities(),
    handlers = M.handlers,
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,

        includeCompletionsForModuleExports = true,
        quotePreference = "auto",
      },
      tsserver_format_options = {
        allowIncompleteCompletions = false,
        allowRenameOfImportPath = false,
      },
    },
  })
end

return M
