-- local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

local on_attach = function(client, bufnr)
  vim.cmd("command! LspFormat lua vim.lsp.buf.format({async=true})")
end

null_ls.setup({
  sources = {
    -- null_ls.builtins.diagnostics.eslint,
    -- null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettier,
    -- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.formatting.bashls,
    -- null_ls.builtins.formatting.cssls,
  },
  on_attach = on_attach,
})
