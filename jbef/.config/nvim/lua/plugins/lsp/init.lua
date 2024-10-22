local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "SmiteshP/nvim-navic" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "pmizio/typescript-tools.nvim" },
    { "folke/lazydev.nvim" },

    { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  },
}

M.on_attach = require("plugins.lsp.on_attach").on_attach
M.capabilities = require("plugins.lsp.capabilities").setup
M.handlers = require("plugins.lsp.handlers").handlers

M.config = function()
  local servers = require("plugins.lsp.servers")
  local lsp = require("lspconfig")
  local ui = require("config.ui")

  require("plugins.lsp.diagnostics").setup()

  require("mason").setup({
    ui = {
      border = ui.border.Single,
    },
  })
  local server_names = {}
  local n = 0
  for k, _ in pairs(servers) do
    if k ~= "glslls" and k ~= "ts_ls" then
      n = n + 1
      server_names[n] = k
    end
  end

  require("mason-lspconfig").setup({
    ensure_installed = server_names,

    automatic_installation = { exclude = { "glslls", "tsserver" } },
    handlers = {
      function(server_name)
        local opts = vim.tbl_deep_extend("force", {
          on_attach = M.on_attach,
          capabilities = M.capabilities(),
          handlers = M.handlers,
        }, servers[server_name] or {})

        -- if server_name == "lua_ls" then
        if server_name == "kek" then
          require("lazydev").setup({})
        -- elseif server_name == "lua_ls" then
        elseif server_name == "tsserver" then
          lsp["ts_ls"].setup(opts)
        else
          lsp[server_name].setup(opts)
        end
      end,
    },
  })

  require("plugins.lsp.keymaps").common()

  -- lsp["ts_ls"].setup(vim.tbl_deep_extend("force", {
  --   on_attach = M.on_attach,
  --   capabilities = M.capabilities(),
  --   handlers = M.handlers,
  -- }, servers.ts_ls))

  require("typescript-tools").setup({
    single_file_support = false,
    -- cmd = { "typescript-language-server", "--stdio" },
    on_attach = function(client, bufnr)
      M.on_attach(client, bufnr)
    end,
    capabilities = M.capabilities(),
    handlers = M.handlers,
    settings = {
      filetypes = {
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "mdx",
      },
      jsx_close_tag = {
        enable = true,
        filetypes = { "javascriptreact", "typescriptreact" },
      },
      -- separate_diagnostic_server = false,
      -- publish_diagnostic_on = "insert_leave",
      -- documentRangeFormatting = false,
      -- root_dir = function(...)
      --   return require("lspconfig.util").root_pattern(".git")(...)
      -- end,
    },
  })

  -- end
end

return M
