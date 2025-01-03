local lspconfig = require("lspconfig")

local M = {

  vtsls = {
    -- cmd = { "vtsls", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = lspconfig.util.root_pattern(".git"),
    settings = {
      javascript = {
        suggest = {
          names = false,
          completeFunctionCalls = true,
        },
      },
      typescript = {
        suggest = {
          names = false,
          completeFunctionCalls = true,
        },
        preferences = {
          names = false,
        },
      },
    },
  },

  -- -- This is no longer needed as long as I use the plugin typescript-tools.nvim
  -- ts_ls = {
  --   cmd = { "typescript-language-server", "--stdio" },
  --   -- root_dir = function(...)
  --   --   return require("lspconfig.util").root_pattern(".git")(...)
  --   -- end,
  --   -- filetypes = {
  --   --   "javascript",
  --   --   "vue",
  --   -- },
  --   single_file_support = false,
  --   init_options = {
  --     documentFormatting = false,
  --     documentRangeFormatting = true,
  --   },
  --   settings = {
  --     typescript = {
  --       inlayHints = {
  --         includeInlayParameterNameHints = "literal",
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayVariableTypeHints = false,
  --         includeInlayPropertyDeclarationTypeHints = true,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayEnumMemberValueHints = true,
  --       },
  --     },
  --     javascript = {
  --       inlayHints = {
  --         includeInlayParameterNameHints = "all",
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayVariableTypeHints = true,
  --         includeInlayPropertyDeclarationTypeHints = true,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayEnumMemberValueHints = true,
  --       },
  --     },
  --   },
  --   flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  -- },

  -- astro = {},

  -- biome = {},

  -- eslint = {
  --   -- settings = {
  --     -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
  --     -- workingDirectories = { mode = "auto" },
  --     -- packageManager = "pnpm",
  --   -- },
  -- },

  -- graphql = {
  -- filetypes = { "graphql", "typescriptreact", "javascriptreact" },
  -- root_dir = lspconfig.util.root_pattern(".git", ".graphqlrc*", ".graphql.config.*", "graphql.config.*"),
  -- },

  dockerls = {},
  docker_compose_language_service = {
    filetypes = { "yaml.docker-compose" },
  },

  intelephense = {
    stubs = {
      "bcmath",
      "bz2",
      "calendar",
      "Core",
      "curl",
      "date",
      "dba",
      "dom",
      "enchant",
      "fileinfo",
      "filter",
      "ftp",
      "gd",
      "gettext",
      "hash",
      "iconv",
      "imap",
      "intl",
      "json",
      "ldap",
      "libxml",
      "mbstring",
      "mcrypt",
      "mysql",
      "mysqli",
      "password",
      "pcntl",
      "pcre",
      "PDO",
      "pdo_mysql",
      "Phar",
      "readline",
      "recode",
      "Reflection",
      "regex",
      "session",
      "SimpleXML",
      "soap",
      "sockets",
      "sodium",
      "SPL",
      "standard",
      "superglobals",
      "sysvsem",
      "sysvshm",
      "tokenizer",
      "xml",
      "xdebug",
      "xmlreader",
      "xmlwriter",
      "yaml",
      "zip",
      "zlib",
      "wordpress",
      "woocommerce",
      "acf-pro",
      "acf-stubs",
      "wordpress-globals",
      "wp-cli",
      "genesis",
      "polylang",
      "sbi",
    },
    diagnostics = { enable = true },
    files = {
      maxSize = 10000000,
    },
  },

  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  },

  gopls = {},

  lua_ls = {
    Lua = {
      format = {
        enable = false,
      },
      diagnostics = {
        globals = { "vim", "spec" },
      },
      runtime = {
        version = "LuaJIT",
        special = {
          spec = "require",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
      hint = {
        enable = false,
        arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
        await = true,
        paramName = "Disable", -- "All" | "Literal" | "Disable"
        paramType = true,
        semicolon = "All", -- "All" | "SameLine" | "Disable"
        setType = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },

  rust_analyzer = {},

  pyright = {},

  nushell = {},
  bashls = {
    filetypes = { "sh", "bash", "zsh" },
  },

  lemminx = {
    filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
  },

  glslls = {
    cmd = { "glslls", "--stdin" },
    filetypes = { "glsl" },
    root_dir = lspconfig.util.root_pattern(".git"),
    single_file_support = true,
  },

  cssls = {
    root_dir = lspconfig.util.root_pattern(".git"),
    -- settings = {
    --   css = {
    --     validate = true,
    --     lint = {
    --       unknownAtRules = "ignore",
    --     },
    --   },
    -- },
    -- filetypes = { "css", "scss", "less", "typescriptreact", "javascriptreact" },
  },

  css_variables = {
    settings = {
      lookupFiles = { "**/*.less", "**/*.scss", "**/*.sass", "**/*.css" },
    },
    -- filetypes = { "css", "scss", "less", "typescriptreact", "javascriptreact" },
  },

  -- cssmodules_ls = {
  --   init_options = {
  --     camelCase = "dashes",
  --   },
  -- },

  tailwindcss = {
    -- this needs to be installed globally
    cmd = { "tailwindcss-language-server", "--stdio" },
    -- root_dir = lspconfig.util.root_pattern(
    --   "tailwind.config.js",
    --   "tailwind.config.ts",
    --   "postcss.config.js",
    --   "postcss.config.ts",
    --   "package.json",
    --   "node_modules",
    --   ".git"
    -- ),
    settings = {
      tailwindCSS = {
        classAttributes = { "class", "clsx", "cva", "className", "classList", "ngClass" },
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
            -- "clsx\\(([^)]*)\\)",
            { "clsx\\(([^)]*)\\)" },
            { "cn\\(([^)]*)\\)" },
            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
            { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          },
        },
      },
    },
  },
}

return M
