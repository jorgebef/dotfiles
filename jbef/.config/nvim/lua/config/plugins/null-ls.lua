local M = {
  "jose-elias-alvarez/null-ls.nvim",
}

function M.config()
  local null_ls = require("null-ls")

  null_ls.setup({
    sources = {
      -- null_ls.builtins.diagnostics.eslint,
      -- null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.formatting.prettierd,
      -- null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.rustywind,
      -- null_ls.builtins.formatting.bashls,
      -- null_ls.builtins.formatting.cssls,
    },
  })
end

return M
