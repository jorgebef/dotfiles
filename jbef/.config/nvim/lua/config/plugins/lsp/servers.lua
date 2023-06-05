local lspconfig = require("lspconfig")

local M = {
  tsserver = {
    -- cmd = { "bunx", "typescript-language-server", "--stdio" },
    -- cmd = { "typescript-language-server", "--stdio" },
    -- cmd = { "deno", "run", "-A", "--unstable", "npm:typescript-language-server", "--stdio" },
    init_options = {
      hostInfo = "neovim",
    },
    single_file_support = true,
    log = "off",
    trace = { server = "off" },
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
  lua_ls = {},
  rust_analyzer = {},
  pyright = {},
  bashls = {},
  lemminx = {
    filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
  },
  -- glslls = {
  --   cmd = { "glslls" },
  --   filetypes = { "glsl" },
  --   root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
  --   single_file_support = true,
  -- },
  tailwindcss = {
    -- cmd = { "bunx", "tailwindcss-language-server", "--stdio" },
    -- cmd = { "tailwindcss-language-server", "--stdio" },
    root_dir = lspconfig.util.root_pattern(
      "tailwind.config.js",
      "tailwind.config.ts",
      "postcss.config.js",
      "postcss.config.ts",
      "package.json",
      "node_modules",
      ".git"
    ),
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
            -- "clsx\\(\'([^)]*)\'\\)",
            -- "clsx\\(([^)]*)\\)",
            "clsx\\(([^)]*)\\)",
            -- "'([^']*)'",
            -- "(?:'|\"|`)([^']*)(?:'|\"|`)",
          },
        },
      },
    },
  },
}

return M
