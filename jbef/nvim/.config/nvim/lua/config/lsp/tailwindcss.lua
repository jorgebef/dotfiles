vim.lsp.config.tailwindcss = {
  -- cmd = {
  --   "pnpm",
  --   "/Users/jbef/Library/pnpm/tailwindcss-language-server",
  --   "--stdio",
  -- },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      classAttributes = {
        "class",
        "clsx",
        "cva",
        "className",
        "classList",
        "ngClass",
        "pictureClassName",
        "imgClassName",
        "videoClassName",
      },
      classFunctions = { "class", "clsx", "cva", "className", "classList", "cn" },
    },
  },
}

vim.lsp.enable("tailwindcss")
