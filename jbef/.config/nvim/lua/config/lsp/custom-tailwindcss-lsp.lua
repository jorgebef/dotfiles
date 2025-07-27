vim.lsp.config("custom-tailwindcss-lsp", {
  cmd = {
    "node",
    "/Users/jbef/.bun/install/global/node_modules/@tailwindcss/language-server/bin/css-language-server",
    "--stdio",
  },
  filetypes = { "css", "scss", "less", "tailwindcss" },
})

vim.lsp.enable("custom-tailwindcss-lsp")
