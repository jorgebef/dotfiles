-- ❗️ IMPORTANT: As mentioned earlier, this plugin serves as a replacement for typescript-language-server, so you should remove the nvim-lspconfig setup for it.

local M = {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    on_attach = require("config.plugins.lsp.on_attach").on_attach,
    handlers = require("config.plugins.lsp.handlers").handlers,
    init_options = {
      hostInfo = "neovim",
      documentFormatting = false,
      documentRangeFormatting = false,
    },
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = true,
      -- quotePreference = "auto",
    },
  },
}

return M
