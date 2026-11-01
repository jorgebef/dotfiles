return {
  {
    "williamboman/mason.nvim",
    -- dependencies = {
    --   "williamboman/mason-lspconfig.nvim",
    -- },
    config = function()
      require("mason").setup()
      -- require("mason-lspconfig").setup({
      --   ensure_installed = {
      --     "bashls",
      --     "biome",
      --     "biome",
      --     "cssls",
      --     "dockerls",
      --     "docker_compose_language_service",
      --     -- "eslint",
      --     -- "glslls",
      --     "gopls",
      --     "jsonls",
      --     "lua_ls",
      --     -- "nushell",
      --     "pyright",
      --     "rust_analyzer",
      --     -- "sourcekit",
      --     "tailwindcss",
      --     -- "ts_ls",
      --     "yamlls",
      --   },
      --   automatic_installation = true,
      -- })
    end,
  },
}
