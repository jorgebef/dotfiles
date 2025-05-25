vim.lsp.config.tailwindcss = {
  cmd = { "tailwindcss-language-server", "--stdio" },
  settings = {
    tailwindCSS = {
      classAttributes = {
        "class",
        "clsx",
        "cva",
        "className",
        "classList",
        "ngClass",
        "imgClassName",
        "videoClassName",
      },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
      classFunctions = { "class", "clsx", "cva", "className", "classList", "cn" },
    },
  },
}

vim.lsp.enable("tailwindcss")
