local M = {
  tsserver = {
    -- cmd = { "typescript-language-server", "--stdio" },
    init_options = {
      hostInfo = "neovim",
    },
    single_file_support = true,
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    -- flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  },
  -- astro = {},
  sumneko_lua = {},
  rust_analyzer = {},
  pyright = {},
  bashls = {},
  tailwindcss = {
    -- cmd = { "tailwindcss-language-server", "--stdio" },
    settings = {
      tailwindCSS = {
        classAttributes = { "class", "className", "classList", "ngClass" },
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
        experimental = {
          classRegex = {
            "clsx\\('([^)]*)'\\)",
            { "clsx\\(([^)]*)\\)", "'([^']*)'" },
          },
        },
      },
    },
  },
}

return M
